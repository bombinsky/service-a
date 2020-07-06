# frozen_string_literal: true

class ExternalUrlsRequestDecorator < Draper::Decorator
  TIME_FORMAT = "%Y-%m-%d %H:%M"

  def delivery_subject
    "External urls in #{ object.user.nickname }'s home line between #{ start_time } and #{ end_time }"
  end

  private

  def start_time
    object.start_time.strftime(TIME_FORMAT)
  end

  def end_time
    object.end_time.strftime(TIME_FORMAT)
  end
end