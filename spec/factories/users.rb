# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    provider  { 'twitter' }
    sequence(:uid)  { |i| "uid-#{ i }" }
    sequence(:email) { |i| "email-#{ i }@not_existing.domain.com" }
    nickname { 'nickname' }
    secret { 'secret' }
    token { 'token' }
  end
end
