class ProcessExternalUrlsRequest

  URL_REGEXP = /https?:\/\/[\S]+/.freeze

  def initialize(request)
    @request = request
    @external_urls = []
  end

  def call
    begin
      collect_external_urls
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in.succ

      retry
    end

    persist_request
    publish_request
    request
  end

  private

  attr_reader :request

  delegate :user, :start_time, :end_time, to: :request

  def persist_request
    request.transaction do
      @external_urls.uniq.each { |url| request.external_urls.create_or_find_by!(value: url) }
      request.processed!
    end
  end

  def publish_request
    Publish.new('external_urls_delivery_requests', { request_id: request.id }.to_json).call
  end

  def collect_external_urls
    tweets = get_tweets_page

    while tweets.count.positive? && tweets.first.created_at >= start_time.to_time
      tweets.each { |tweet| parse(tweet) if (start_time.to_time..end_time.to_time).include?(tweet.created_at) }
      tweets = get_tweets_page(tweets.last.id.pred)
    end
  end

  def parse(tweet)
    tweet.full_text.scan(URL_REGEXP).each do |url|
      final_url = FinalRedirectUrl.final_redirect_url(url)

      @external_urls << final_url if final_url.present? && !final_url.include?('//twitter.com')
    end
  end

  def get_tweets_page(max_id = nil)
    TwitterGateway.new.home_timeline(user, options(max_id))
  end

  def options(max_id)
    page_options.merge(max_id: max_id).compact
  end

  def page_options
    { exclude_replies: true, trim_user: true, include_rts: false, tweet_mode: :extended, count: 200 }
  end
end