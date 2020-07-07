# frozen_string_literal: true

describe Publish do
  subject(:service_call) { described_class.new(queue_name, payload).call }
  let(:queue_name) { 'queue_name' }
  let(:payload) { { var_1: 'var_1' } }

  let(:channel) { instance_double(Bunny::Channel) }
  let(:queue) { instance_double(Bunny::Queue, name: queue_name) }
  let(:exchange) { instance_double(Bunny::Exchange) }

  before do
    allow(Connection.bunny).to receive(:start)
    allow(Connection.bunny).to receive(:create_channel).and_return channel
    allow(Connection.bunny).to receive(:close)
    allow(channel).to receive(:queue).and_return queue
    allow(channel).to receive(:default_exchange).and_return exchange
    allow(exchange).to receive(:publish)
  end

  it 'queues with proper options' do
    service_call

    expect(channel).to have_received(:queue).with(queue_name, durable: true, ack: true)
  end

  it 'publishes messages to queue' do
    service_call

    expect(exchange).to have_received(:publish).with(payload, routing_key: queue_name)
  end
end
