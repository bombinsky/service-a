# frozen_string_literal: true

# Service Object responsible for delivery processed request results
class ProcessExternalUrlsDeliveryRequest
  TEMPLATE_NAME = 'external_urls_request_results'

  def initialize(request)
    @request = request.decorate
  end

  def call
    return true if request.sent?

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
      from: Settings.mail_from,
      to: request.email,
      headers: { 'Reply-To': Settings.reply_to },
      template_name: TEMPLATE_NAME,
      template_payload: template_payload
    }
  end

  def template_payload
    {
      nickname: request.user.nickname,
      request_id: request.id,
      request_start_time: request.start_time,
      request_end_time: request.end_time,
      request_created_at: request.created_at,
      request_updated_at: request.updated_at,
      urls: request.external_urls.map { |object| { url: object.url, page_title: object.page_title } }
    }
  end
end
