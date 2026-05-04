class FollowUp < ApplicationRecord
  belongs_to :job_application

  # Validations
  validates :remind_at, presence: true
  validates :message, presence: true
  validates :completed, inclusion: { in: [true, false] }
  validate :remind_at_can_not_be_in_past, on: :create

  # Scopes
  scope :pending,   -> { where(completed: false).where("remind_at >= ?", Time.current) }
  scope :overdue,   -> { where(completed: false).where("remind_at >= ?", Time.current) }
  scope :completed, -> { where(completed: true) }
  scope :today,     -> { where(remind_at: Time.current.beginning_of_day..Time.current.end_of_day) }
  scope :upcoming,  -> { where(completed: false).where("remind_at > ?", Time.current).order(:remind_at) }
  scope :recent,    -> { order(remind_at: :asc) }

  # Callback
  before_save :set_completed_at

  private
  def remind_at_can_not_be_in_past
    if remind_at.present? && remind_at < Time.current
      errors.add(:remind_at, "cannot be in the past")
    end
  end

  def set_completed_at
    if completed? && completed_at.blank?
      self.completed_at = Time.current
    else
      self.completed_at = nil
    end
  end
end
