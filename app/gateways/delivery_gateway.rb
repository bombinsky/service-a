class DeliveryGateway

  def send_email(from:, to:, headers:, template_name:, template_payload:)
    params = {
      from: from,
      to: to,
      headers: headers,
      template_name: template_name,
      template_payload: template_payload
    }
    connection.post('/template_email_deliveries', { template_email: params }.to_json, content_type: 'application/json')
  end

  private

  def connection
    @connection ||= begin
      Faraday.new(url: Settings.service_b_url).tap do |connection|
        connection.basic_auth(Treasury.service_b_basic_auth_username, Treasury.service_b_basic_auth_password)
      end
    end
  end
end
