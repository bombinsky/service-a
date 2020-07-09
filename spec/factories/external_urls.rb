# frozen_string_literal: true

FactoryBot.define do
  factory :external_url do
    external_urls_request
    sequence(:url) { |i| "https://external_link.com/url-#{i}" }
    page_title { 'Page title' }
  end
end
