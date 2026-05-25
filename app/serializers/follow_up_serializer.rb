class FollowUpSerializer < ActiveModel::Serializer
    attributes  :id,
                :message,
                :remind_at,
                :completed,
                :completed_at,
                :job_application_id,
                :created_at,
                :updated_at,
                :status

  def status
    if object.completed?
      "completed"
    elsif object.remind_at < Time.current
      "overdue"
    else
      "pending"
    end
  end
end
