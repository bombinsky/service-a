# frozen_string_literal: true

# Service Object responsible for delivery processed request results
class ProcessExternalUrlsDeliveryRequest
  FROM = 'twitter_reader@service-a.com'
  REPLY_TO = 'no-reply@anywhere.com'
  TEMPLATE_NAME = 'external_urls_request_results'

  def initialize(request)
    @request = request.decorate
  end

  def call
    request.sent! if delivery.success?

    delivery.success?
  end

  private

  attr_reader :request

  def delivery
    @delivery ||= DeliveryGateway.new.send_email(delivery_params)
  end

  def delivery_params
    {
      from: FROM,
      to: request.email,
      headers: { 'Reply-To': REPLY_TO },
      template_name: TEMPLATE_NAME,
      template_payload: template_payload
    }
  end

  def template_payload
    {
      nickname: request.user.nickname,
      request_id: request.id,
      request_created_at: request.created_at,
      request_completed_at: request.updated_at,
      urls: request.external_urls.map { |object| { url: object.url, page_title: object.page_title } }
    }
  end
end