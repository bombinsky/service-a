describe ExternalUrlsRequestsProcessor do
  describe '#work' do
    subject(:work) { worker.work(msg) }

    let(:worker) { described_class.new }
    let(:external_urls_request) { create :external_urls_request }
    let(:msg) { { 'request_id' => external_urls_request.id }.to_json }

    context 'when ProcessExternalUrlsRequest will succeed' do
      before { allow_service_call(ProcessExternalUrlsRequest, with: external_urls_request) }

      it { is_expected.to eq :ack }
    end

    context 'when ProcessExternalUrlsRequest will failure' do
      before do
        allow(ProcessExternalUrlsRequest).to receive(:new).and_raise(RuntimeError, 'some error message')
        allow(worker.logger).to receive(:info)
      end

      it { is_expected.to eq :requeue }

      it 'logs error message' do
        work

        expect(worker.logger).to have_received(:info).with('some error message')
      end
    end
  end
end
