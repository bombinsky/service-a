Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, Treasury.twitter_consumer_key, Treasury.twitter_consumer_secret
end
