# frozen_string_literal: true

FactoryBot.define do
  factory :external_urls_request do
    user
    sequence(:email) { |i| "email-#{ i }@not_existing.domain.com" }
    start_time { Time.current - 1.day }
    end_time { Time.current }
  end
end
