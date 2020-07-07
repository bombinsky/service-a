# frozen_string_literal: true

# This model represents ExternalUrlsRequest
class ExternalUrlsRequest < ApplicationRecord
  belongs_to :user
  has_many :external_urls

  validates :email, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  validate :end_time_after_start_time
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  enum status: %i[created processed sent]

  private

  after_initialize do
    if new_record?
      self.start_time ||= Time.current - 1.day
      self.end_time ||= Time.current
    end
  end

  def end_time_after_start_time
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, "must be before the end_time")
      errors.add(:end_time, "must be after the start_time")
    end
  end
end