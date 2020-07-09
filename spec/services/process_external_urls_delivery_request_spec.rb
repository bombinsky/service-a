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
      request_updated_at: '2020-01-11 23:11:22',
      request_end_time: '2020-01-04 11:33',
      request_start_time: '2020-01-01 12:30',
      urls: [
        { page_title: 'Page title', url: 'https://external_link.com/url-2' },
        { page_title: 'Page title', url: 'https://external_link.com/url-3' }
      ]
    }
  end

  let(:delivery_params) do
    {
      from: Settings.mail_from,
      to: decorated_request.email,
      headers: { 'Reply-To': Settings.reply_to },
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
