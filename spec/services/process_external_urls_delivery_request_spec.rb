# frozen_string_literal: true

describe ProcessExternalUrlsDeliveryRequest do
  let(:service) { described_class.new(external_urls_request) }
  let(:external_urls_request) do
    create(:external_urls_request, :with_external_urls, :with_fixed_dates, external_urls_count: 2)
  end
  let(:decorated_request) { external_urls_request.decorate }
  let(:delivery_gateway) { instance_double(DeliveryGateway) }
  let(:delivery_result) { OpenStruct.new(success?: true) }

  let(:template_payload) do
    {
      nickname: decorated_request.user.nickname,
      request_id: decorated_request.id,
      request_created_at: '2020-01-10 22:55:33',
      request_completed_at: '2020-01-11 23:11:22',
      urls: decorated_request.external_urls.map(&:value)
    }
  end

  let(:delivery_params) do
    {
      from: described_class::FROM,
      to: decorated_request.email,
      headers: { 'Reply-To': described_class::REPLY_TO },
      template_name: described_class::TEMPLATE_NAME,
      template_payload: template_payload
    }
  end

  describe '#call' do
    subject(:service_call) { service.call }

    before do
      allow(DeliveryGateway).to receive(:new).and_return delivery_gateway
      allow(delivery_gateway).to receive(:send_email).with(delivery_params).and_return(delivery_result)
    end

    it 'requests delivery with proper params' do
      service_call

      expect(delivery_gateway).to have_received(:send_email).with delivery_params
    end
  end
end
