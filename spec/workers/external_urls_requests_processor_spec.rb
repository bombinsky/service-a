# frozen_string_literal: true

describe ExternalUrlsRequestsProcessor do
  describe '#work' do
    subject(:work) { worker.work(msg) }

    let(:worker) { described_class.new }
    let(:external_urls_request) { create :external_urls_request }
    let(:msg) { { 'request_id' => external_urls_request.id }.to_json }

    it_behaves_like 'worker with service object behind', ProcessExternalUrlsRequest
  end
end
