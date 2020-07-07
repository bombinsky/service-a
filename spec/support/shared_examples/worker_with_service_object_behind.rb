# frozen_string_literal: true

shared_examples 'worker with service object behind' do |service_object_class|
  context 'when ProcessExternalUrlsRequest will succeed' do
    before { allow_service_call(service_object_class, with: external_urls_request, to_return: true) }

    it { is_expected.to eq :ack }
  end

  context 'when ProcessExternalUrlsRequest will failure' do
    before do
      allow(service_object_class).to receive(:new).and_raise(RuntimeError, 'some error message')
      allow(worker.logger).to receive(:info)
    end

    it { is_expected.to eq :requeue }

    it 'logs error message' do
      work

      expect(worker.logger).to have_received(:info).with('some error message')
    end
  end
 end
