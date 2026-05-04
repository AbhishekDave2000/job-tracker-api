class Contact < ApplicationRecord
  belongs_to :job_application

  validates :name,  presence: true, 
                    length: { minimum: 2, maximum: 100 }
  validates :email, presence: true,
                    format: { 
                      with: URI::MailTo::EMAIL_REGEXP,
                      message: "must be a valid email address" 
                    }
  validates :phone_number,  format: { 
                              with: /\A[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}\z/,
                              message: "must be a valid phone number" 
                            },
                            allow_blank: true

  scope :recent, -> { order(created_at: :desc) }

  # Callback
  before_save :normalize_email

  private
  def normalize_email
    self.email = email.downcase.strip if email.present?
  end
end