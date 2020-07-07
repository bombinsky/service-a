# frozen_string_literal: true

# ExternalUrlsRequestDecorator with few methods required to prepare email payload
class ExternalUrlsRequestDecorator < Draper::Decorator
  TIME_FORMAT = '%Y-%m-%d %H:%M'
  TIMESTAMP_FORMAT = '%Y-%m-%d %H:%M:%S'

  delegate_all

  def delivery_subject
    "External urls in #{object.user.nickname}'s home line between #{start_time} and #{end_time}"
  end

  def start_time
    object.start_time.strftime(TIME_FORMAT)
  end

  def end_time
    object.end_time.strftime(TIME_FORMAT)
  end

  def created_at
    object.created_at.strftime(TIMESTAMP_FORMAT)
  end

  def updated_at
    object.updated_at.strftime(TIMESTAMP_FORMAT)
  end
end
