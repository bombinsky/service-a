# frozen_string_literal: true

FactoryBot.define do
  factory :external_urls_request do
    user
    sequence(:email) { |i| "email-#{i}@not_existing.domain.com" }
    start_time { Time.current - 11.days }
    end_time { Time.current - 10.days }
    created_at { Time.current - 2.days }
    updated_at { Time.current - 1.days }

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

    trait :with_fixed_dates do
      start_time { '2020-01-01 12:30:00' }
      end_time { '2020-01-04 11:33:00' }
      created_at { '2020-01-10 22:55:33' }
      updated_at { '2020-01-11 23:11:22' }
    end
  end
end
