class Api::V1::JobApplicationsController < ApplicationController
    before_action :set_job_application, only: [ :show, :update, :destroy ]

    # GET /api/v1/job_applications
    def index
        applications = current_user.job_applications
        render json: { applications: applications }, status: :ok
    end

    # GET /api/v1/job_applications/:id
    def show
        render json: { application: @job_application }, status: :ok
    end

    # POST /api/v1/job_applications
    def create
        job_application = current_user.job_applications.new(application_params)

        if job_application.save!
            render json: { application: job_application }, status: :created
        else
            render json: { errors: job_application.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # PUT /api/v1/job_applications/:id
    def update
        if @job_application.update(application_params)
            render json: { application: @job_application }, status: :ok
        else
            render json: { errors: @job_application.errors.full_messages }, status: :unprocessable_entity
        end
    end

    # DELETE /api/v1/job_applications/:id
    def destroy
        @job_application.destroy!
        render json: { message: "Deleted Successfully" }, status: :ok
    end

    private
    def set_job_application
        @job_application = current_user.job_applications.find(params[:id])
    rescue
        render json: { error: "Job application not found." }, status: :not_found
    end

    def application_params
        params.require(:application).permit(:company_name, :job_title, :job_url, :job_description, :status, :applied_date, :salary_min, :salary_max, :location, :remote, :notes)
    end
end
