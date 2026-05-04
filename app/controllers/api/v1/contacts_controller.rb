class Api::V1::ContactsController < ApplicationController
    before_action :set_job_application, only: [:index]
    before_action :set_contact, only: [:show, :update, :destroy]

    # GET /api/v1/contacts_controller
    def index
        contacts = @job_application.contacts.recent

        render json: {
            status: "success",
            message: "Contacts retrieved successfully",
            data: ContactSerializer.new(contacts).serializable_hash
        }, status: :ok
    end

    def show
        render json: {
            status: "success",
            message: "Contact retrieved successfully",
            data: ContactSerializer.new(contact).serializable_hash
        }, status: :ok
    end

    private
    def set_job_application
        @job_application = current_user.job_applications.find(params[:job_application_id])
    rescue ActiveRecord::RecordNotFound
        render json: {
            status: "error",
            message: "Job Application Not Found",
        }, status: :not_found
    end

    def set_contact
        @contact = Contact.joins(:job_application)
                            .where(job_application: { user_id: current_user.id })
                            .find(params[:id])
    rescue ActiveRecord::RecordNotFound
        render json: {
            status:  "error",
            message: "Contact not found"
        }, status: :not_found
    end

    def contact_params
        params.require(:contact).permit(:email, :name, :note, :phone_number)
    end

    def format_errors(errors)
        errors.messages.map do |field, messages|
            { field: field, messages: messages }
        end
    end
end