class Api::V1::FollowUpsController < ApplicationController
  before_action :set_job_application, only: [ :index, :create ]
  before_action :set_follow_up, only: [ :show, :update, :destroy, :complete_follow_up ]

  def index
    follow_ups = filter_follow_ups(@job_application.follow_ups)

    render json: {
      status: "success",
      message: "Follow ups retrieved successfully",
      data: follow_ups.map { |f| FollowUpSerializer.new(f).as_json },
      meta: { total: follow_ups.count }
    }, status: :ok
  end

  def create
    follow_up = @job_application.follow_ups.new(follow_up_params)
    if follow_up.save
      render json: {
        status: "success",
        message: "Follow Up created successfully",
        data: FollowUpSerializer.new(follow_up).as_json
      }, status: :ok
    else
      render json: {
        status: "error",
        message: "Not able to create the follow up",
        errors: format_errors(follow_up.errors)
      }, status: :unprocessable_entity
    end
  end

  def show
    render json: {
      status: "success",
      message: "Successfully retrieved Follow ups",
      data: FollowUpSerializer.new(@follow_up).as_json
    }, status: :ok
  end

  def update
    if @follow_up.update(follow_up_params)
      render json: {
        status: "success",
        message: "Successfully updated the follow up",
        data: FollowUpSerializer.new(@follow_up).as_json
      }, status: :ok
    else
      render json: {
        status: "error",
        message: "Can not update the follow up"
      }, status: :unprocessable_entity
    end
  end

  def destroy
    @follow_up.destroy
    render json: {
      status: "success",
      message: "Followup deleted successfully"
    }, status: :ok
  end

  def complete_follow_up
    if @follow_up.completed?
      render json: {
        status: "error",
        message: "Follow up is already completed"
      }, status: :unprocessable_entity
    else
      @follow_up.update!(completed: true, completed_at: Time.current)
      render json: {
        status: "success",
        message: "Successfully completed follow up",
        data: FollowUpSerializer.new(@follow_up).as_json
      }, status: :ok
    end
  end

  private
  def follow_up_params
    params.permit(:message, :remind_at, :completed)
  end

  def set_job_application
    @job_application = current_user.job_applications.find(params[:job_application_id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Job Application not found."
    }, status: :not_found
  end

  def set_follow_up
    @follow_up = FollowUp.joins(:job_application)
                        .where(job_application: { user_id: current_user.id })
                        .find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      status: "error",
      message: "Follow Ups not found."
    }, status: :not_found
  end

  def filter_follow_ups(follow_ups)
    case params[:status]
    when "pending" then follow_ups.pending
    when "overdue" then follow_ups.overdue
    when "completed" then follow_ups.completed
    when "today" then follow_ups.today
    when "upcoming" then follow_ups.upcoming
    else follow_ups.recent
    end
  end

  def format_errors(errors)
    errors.messages.map do |field, messages|
      { field: field, messages: messages }
    end
  end
end
