class ContactSerializer
    include JSONAPI::Serializer
    
    attributes  :id,
                :name,
                :email,
                :phone_number,
                :note,
                :job_application_id,
                :created_at,
                :updated_at
end