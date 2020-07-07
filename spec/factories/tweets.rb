# frozen_string_literal: true

FactoryBot.define do
  factory :tweet, class: 'OpenStruct' do
    sequence(:id)  { |i| i }
    created_at { Time.current - 1.hour }
    sequence(:full_text) { |i| "Full text of tweet with https://link#{i} https://link#{i + 10000}" }

    trait :before_request_range do
      created_at { Time.current - 2.days }
    end
  end
end
