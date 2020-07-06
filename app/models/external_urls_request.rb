class ExternalUrlsRequest < ApplicationRecord

  belongs_to :user
  has_many :external_urls

  validates :email, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :end_time_after_start_time

  enum status: %i[created processed sent]

  def delivery_subject
    "#{ user.nickname }'s urls between #{ start_time } and #{ end_time }"
  end

  private

  after_initialize do
    if self.new_record?
      self.start_time ||= Time.now - 1.day
      self.end_time ||= Time.now
    end
  end

  def end_time_after_start_time
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, "must be before the end_time")
      errors.add(:end_time, "must be after the start_time")
    end
  end
end