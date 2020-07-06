# frozen_string_literal: true

describe ProcessExternalUrlsRequest do
  subject(:service_call) { CollectExternalUrls.new.call }

  it 'ddd' do
    ProcessExternalUrlsRequest.new(ExternalUrlsRequest.last).call
  end
end
