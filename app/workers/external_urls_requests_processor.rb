class ExternalUrlsRequestsProcessor
  include Sneakers::Worker
  from_queue 'external_urls_requests', ack: true

  def work(msg)
    begin
      request = ExternalUrlsRequest.find(ActiveSupport::JSON.decode(msg)['request_id'])
      ProcessExternalUrlsRequest.new(request).call
      ack!
    rescue Exception => e
      logger.info e.message
      requeue!
    end
  end
end