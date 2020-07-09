# frozen_string_literal: true

# Publish
class Publish
  def initialize(queue_name, payload)
    @queue_name = queue_name
    @payload = payload
  end

  def call
    connection = Connection.bunny
    connection.start

    channel = connection.create_channel
    queue = channel.queue(queue_name, durable: true, ack: true)
    channel.default_exchange.publish(payload, routing_key: queue.name)

    connection.close
  end

  private

  attr_reader :queue_name, :payload
end

