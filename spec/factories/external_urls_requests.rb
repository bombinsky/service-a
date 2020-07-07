# frozen_string_literal: true

FactoryBot.define do
  factory :external_urls_request do
    user
    sequence(:email) { |i| "email-#{ i }@not_existing.domain.com" }
    start_time { Time.current - 1.day }
    end_time { Time.current }

    trait :processed do
      status { :processed }
    end

    trait :with_external_urls do
      transient { external_urls_count { 1 } }

      status { :processed }
      after(:create) do |request, evaluator|
        create_list(:external_url, evaluator.external_urls_count, external_urls_request: request)
      end

    end
  end
end
