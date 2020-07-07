# frozen_string_literal: true

class User < ApplicationRecord

  has_many :external_urls_requests

  validates :nickname, presence: true
  validates :token, presence: true
  validates :secret, presence: true

  def self.find_or_create_with_twitter_auth_hash(auth_hash)
    user = find_or_initialize_by(provider: auth_hash.provider, uid: auth_hash.uid)
    user.assign_attributes(
      nickname: auth_hash.info.nickname,
      email: auth_hash.info.email.presence,
      secret: auth_hash.credentials.secret,
      token: auth_hash.credentials.token
    )
    user.save!
    user
  end
end