class DeliveryGateway

  # mail_to:, subject:, headers:, template_name:, template_payload:
  def send_email(delivery_params)
    #connection.post('/emails', delivery_params.to_json, content_type: 'application/json')
    return OpenStruct.new(success?: true)
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