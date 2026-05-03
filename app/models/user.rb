class User < ApplicationRecord
    has_secure_password

    has_many :job_applications, dependent: :destroy

    validates :email, presence: true, uniqueness: { case_sensitive: false },
                        format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :first_name, presence: true
    validates :last_name, presence: true

    before_save { self.email = email.downcase }
end
