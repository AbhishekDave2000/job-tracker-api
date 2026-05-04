class JobApplication < ApplicationRecord
  belongs_to :user

  has_many :contacts, dependent: :destroy
  has_many :follow_ups, dependent: :destroy
  has_many :status_histories, dependent: :destroy

  enum :status, {
    bookmarked:   0,
    applied:      1,
    interviewed:  2,
    offer:        3,
    rejected:     4,
    withdrawn:    5
  }

  validates :company_name, presence: true
  validates :job_title, presence: true
  validates :status, presence: true

  before_update :track_status_change, if: :status_changed?

  private
  def track_status_change
    status_histories.build(
      previous_status: status_change.first,
      new_status: status_change.second,
      changed_at: Time.current
    )
  end

end

