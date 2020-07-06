class ExternalUrlsDeliveryRequestsProcessor
  include Sneakers::Worker
  from_queue 'external_urls_delivery_requests', ack: true

  def work(msg)
    begin
      request = ExternalUrlsRequest.find(ActiveSupport::JSON.decode(msg)['request_id'])

      return ProcessExternalUrlsDeliveryRequest.new(request).call ? ack! : requeue! if request.processed?

      ack!
    rescue Exception => e
      logger.info e.message
      requeue!
    end
  end
end