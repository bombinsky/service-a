# frozen_string_literal: true

FactoryBot.define do
  factory :external_url do
    external_urls_request
    sequence(:value) { |i| "https://external_link.com/url-#{ i }" }
  end
end
