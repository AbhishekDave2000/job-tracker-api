class Api::V1::ContactsController < ApplicationController
    before_action :set_job_application, only: [ :index, :create ]
    before_action :set_contact, only: [ :show, :update, :destroy ]

    # GET /api/v1/contacts_controller
    def index
        contacts = @job_application.contacts.recent

        render json: {
            status: "success",
            message: "Contacts retrieved successfully",
            data: contacts.map { |c| ContactSerializer.new(c).as_json },
            total: contacts.count
        }, status: :ok
    end

    def show
        render json: {
            status: "success",
            message: "Contact retrieved successfully",
            data: ContactSerializer.new(@contact).as_json
        }, status: :ok
    end

    def create
        contact = @job_application.contacts.new(contact_params)

        if contact.save
            render json: {
                status: "success",
                message: "Contact added successfully.",
                data: ContactSerializer.new(contact).as_json
            }, status: :created
        else
            render json: {
                status: "error",
                message: "Failed to create contact.",
                errors: format_errors(contact.errors)
            }
        end
    end

    def update
        if @contact.update(contact_params)
            render json: {
                status: "success",
                message: "Contact updated successfully",
                data: ContactSerializer.new(@contact).as_json
            }, status: :ok
        else
            render json: {
                status: "error",
                message: "Failed to update the contact of the person",
                errors: format_errors(@contact.errors)
            }, status: :unprocessable_entity
        end
    end


    def destroy
        @contact.destroy
        render json: {
            status: "success",
            message: "Contact deleted successfully"
        }, status: :ok
    end

    private
    def set_job_application
        @job_application = current_user.job_applications.find(params[:job_application_id])
    rescue ActiveRecord::RecordNotFound
        render json: {
            status: "error",
            message: "Job Application Not Found"
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
