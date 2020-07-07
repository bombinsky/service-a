# frozen_string_literal: true

describe CreateExternalUrlsRequest do
  let(:service) { described_class.new(user, attributes) }
  let(:user) { create :user }

  let(:attributes) do
    {
      email: email,
      start_time: Time.current - 1.day,
      end_time: Time.current
    }
  end

  describe '#call' do
    subject(:service_call) { service.call }

    before { allow_service_call(Publish, with: ['external_urls_requests', kind_of(String)]) }

    context 'when valid attributes provided' do
      let(:email) { 'email@domain.com' }

      it { is_expected.to be_an ExternalUrlsRequest }
      it { is_expected.to be_persisted }

      it 'creates ExternalUrlsRequest' do
        expect { service_call }.to change(ExternalUrlsRequest, :count).by(1)
      end

      it 'publish brand new request to external_urls_requests queue' do
        request = service_call

        expect(Publish).to have_received(:new).with('external_urls_requests', { 'request_id' => request.id }.to_json)
      end
    end

    context 'when invalid attributes provided' do
      let(:email) { 'email@domain' }

      it { is_expected.to be_an ExternalUrlsRequest }
      it { is_expected.not_to be_persisted }
      it { is_expected.not_to be_valid }

      it 'does not create ExternalUrlsRequest' do
        expect { service_call }.not_to change(ExternalUrlsRequest, :count)
      end
    end
  end
end
