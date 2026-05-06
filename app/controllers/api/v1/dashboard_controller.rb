# app/controllers/api/v1/dashboard_controller.rb
module Api
  module V1
    class DashboardController < ApplicationController
      # GET /api/v1/dashboard
      def index
        applications = current_user.job_applications

        render json: {
          status:  "success",
          message: "Dashboard data retrieved successfully",
          data: {
            overview:        overview_stats(applications),
            by_status:       by_status_stats(applications),
            follow_ups:      follow_up_stats,
            recent_activity: recent_activity(applications),
            monthly_trend:   monthly_trend(applications),
            top_companies:   top_companies(applications)
          }
        }, status: :ok
      end

      private

      def overview_stats(applications)
        {
          total_applications:  applications.count,
          active_applications: applications.where.not(status: [ :rejected, :withdrawn ]).count,
          offers_received:     applications.offer.count,
          interviews_pending:  applications.interview.count,
          response_rate:       calculate_response_rate(applications)
        }
      end

      def by_status_stats(applications)
        JobApplication.statuses.keys.map do |status|
          {
            status: status,
            count:  applications.send(status).count
          }
        end
      end

      def follow_up_stats
        all_follow_ups = FollowUp.joins(:job_application)
                                  .where(job_applications: { user_id: current_user.id })
        {
          total:      all_follow_ups.count,
          pending:    all_follow_ups.pending.count,
          overdue:    all_follow_ups.overdue.count,
          completed:  all_follow_ups.completed.count,
          due_today:  all_follow_ups.today.count,
          upcoming:   all_follow_ups.upcoming.limit(5).map do |f|
                        {
                          id:        f.id,
                          message:   f.message,
                          remind_at: f.remind_at,
                          company:   f.job_application.company_name
                        }
                      end
        }
      end

      def recent_activity(applications)
        applications.order(updated_at: :desc).limit(5).map do |app|
          {
            id:           app.id,
            company_name: app.company_name,
            job_title:    app.job_title,
            status:       app.status,
            updated_at:   app.updated_at
          }
        end
      end

      def monthly_trend(applications)
        6.downto(0).map do |months_ago|
          date  = months_ago.months.ago
          count = applications.where(
            applied_date: date.beginning_of_month..date.end_of_month
          ).count

          {
            month: date.strftime("%B %Y"),
            count: count
          }
        end
      end

      def top_companies(applications)
        applications.group(:company_name)
                    .order("count_all DESC")
                    .limit(5)
                    .count
                    .map { |company, count| { company: company, applications: count } }
      end

      def calculate_response_rate(applications)
        total = applications.count
        return 0 if total.zero?

        responded = applications.where(status: [ :interview, :offer, :rejected ]).count
        ((responded.to_f / total) * 100).round(1)
      end
    end
  end
end
