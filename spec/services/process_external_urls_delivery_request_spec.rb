# frozen_string_literal: true

describe ProcessExternalUrlsDeliveryRequest do
  subject(:service_call) { service.call }

  let(:service) { described_class.new(external_urls_request) }
  let(:external_urls_request) { create :external_urls_request, :with_external_urls, external_urls_count: 2 }
  let(:delivery_gateway) { instance_double(DeliveryGateway) }
  let(:delivery_result) { OpenStruct.new(success?: true)}

  let(:template_payload) do
    {
      nickname: external_urls_request.user.nickname,
      request_id: external_urls_request.id,
      request_created_at: external_urls_request.created_at,
      request_completed_at: external_urls_request.updated_at,
      urls: external_urls_request.external_urls.map(&:value)
    }
  end

  let(:delivery_params) do
    {
      from: described_class::FROM,
      to: external_urls_request.email,
      subject: external_urls_request.decorate.delivery_subject,
      headers: { 'Reply-To': described_class::REPLY_TO },
      template_name: described_class::TEMPLATE_NAME,
      template_payload: template_payload
    }
  end

  before do
    allow(DeliveryGateway).to receive(:new).and_return delivery_gateway
    allow(delivery_gateway).to receive(:send_email).with(delivery_params).and_return(delivery_result)
  end

  it 'requests delivery with proper params' do
    service_call

    expect(delivery_gateway).to have_received(:send_email).with delivery_params
  end
end
