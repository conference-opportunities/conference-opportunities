Rails.application.config.application_twitter_id =
  if Rails.env.test?
    "FAKE_TWITTER_ID"
  else
    Twitter::REST::Client.new(
      consumer_key: ENV.fetch("TWITTER_CONSUMER_KEY"),
      consumer_secret: ENV.fetch("TWITTER_CONSUMER_SECRET"),
      access_token: ENV.fetch("TWITTER_ACCESS_TOKEN"),
      access_token_secret: ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET"),
    ).user.id
  end
