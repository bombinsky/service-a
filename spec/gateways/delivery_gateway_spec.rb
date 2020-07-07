describe DeliveryGateway do
  describe '#send_email' do
    subject(:send_email) { DeliveryGateway.new.send_email(delivery_params)}

    let(:delivery_params) do
      {
        from: 'from',
        to: 'mail_to',
        subject: 'subject',
        headers: 'headers',
        template_name: 'template_name',
        template_payload: 'template_payload'
      }
    end

    let(:authorization) do
      Faraday.new.basic_auth(Treasury.service_b_basic_auth_username, Treasury.service_b_basic_auth_password)
    end

    before do
      stub_const('ENV',
        'SERVICE_B_URL' => 'http://service_b_url',
        'SERVICE_B_BASIC_AUTH_USERNAME' => 'username',
        'SERVICE_B_BASIC_AUTH_PASSWORD' => 'password'
      )

      stub_request(:post, "http://service_b_url/emails").
        with(
          body: delivery_params.to_json,
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=> authorization,
            'Content-Type'=>'application/json',
            'User-Agent'=>'Faraday v1.0.1'
          }).
        to_return(status: response_status, body: "", headers: {})
    end

    context 'when delivery success' do
      let(:response_status) { 200 }

      it { is_expected.to be_success }
    end

    context 'when delivery failure' do
      let(:response_status) { 422 }

      it { is_expected.not_to be_success }
    end
  end
end
