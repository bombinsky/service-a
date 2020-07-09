# frozen_string_literal: true

# CreateExternalUrlsRequest
class CreateExternalUrlsRequest

  def initialize(user, attributes)
    @user = user
    @attributes = attributes
  end

  def call
    if external_urls_request.valid?
      external_urls_request.save!

      Publish.new('external_urls_requests', payload).call
    end

    external_urls_request
  end

  private

  attr_reader :user, :attributes

  def payload
    { request_id: external_urls_request.id }.to_json
  end

  def external_urls_request
    @external_urls_request ||= user.external_urls_requests.build(attributes)
  end
end

