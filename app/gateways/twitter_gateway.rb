class TwitterGateway

  require 'twitter'

  def home_timeline(user, options)
    client(user).home_timeline(options)
  end

  private

  def client(user)
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = Treasury.twitter_consumer_key
      config.consumer_secret     = Treasury.twitter_consumer_secret
      config.access_token        = user.token
      config.access_token_secret = user.secret
    end
  end
end