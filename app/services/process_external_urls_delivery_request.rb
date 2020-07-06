class ProcessExternalUrlsDeliveryRequest

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
      mail_to: request.email,
      subject: request.delivery_subject,
      headers: { 'Reply-To': 'no-reply@anywhere.com'},
      template_name: 'external_urls_request_results',
      template_payload: template_payload
    }
  end

  def template_payload
    {
      nickname: request.user.nickname,
      request_id: request.id,
      request_created_at: request.created_at,
      request_completed_at: request.updated_at,
      urls: request.external_urls.map(&:value)
    }
  end
end