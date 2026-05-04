class FollowUp < ApplicationRecord
  belongs_to :job_application

  validates :remind_at, presence: true

  scope :pending, -> { where(completed: false).where("remind_at >= ?", Time.current) }
  scope :overdue, -> { where(completed: false).where("remind_at >= ?", Time.current) }
  scope :completed, -> { where(completed: true) }
end
