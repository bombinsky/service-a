# frozen_string_literal: true

describe CreateExternalUrlsRequest do
  subject(:service_call) { service.call }

  let(:service) { described_class.new(user, attributes) }
  let(:user) { create :user }

  let(:attributes) do
    {
      email: 'email@email.com',
      start_time: Time.current - 1.day,
      end_time: Time.current
    }
  end

  before do
    allow_service_call(Publish, with: ['external_urls_requests', kind_of(String)])
  end

  it { is_expected.to be_an ExternalUrlsRequest }
  it { is_expected.to be_persisted }
end
