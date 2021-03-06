# frozen_string_literal: true

module OauthSpecHelper
  def login_with_oauth(service = :twitter)
    visit "/auth/#{service}"
  end
end
