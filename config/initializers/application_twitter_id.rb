class TwitterCredentials < Struct.new(:consumer_key, :consumer_secret, :access_token, :access_token_secret)
  def self.create
    new(
      ENV["TWITTER_CONSUMER_KEY"],
      ENV["TWITTER_CONSUMER_SECRET"],
      ENV["TWITTER_ACCESS_TOKEN"],
      ENV["TWITTER_ACCESS_TOKEN_SECRET"],
    )
  end

  def twitter_uid
    return "FAKE_TWITTER_UID" if Rails.env.test? || consumer_key.blank?
    Twitter::REST::Client.new(
      consumer_key: consumer_key,
      consumer_secret: consumer_secret,
      access_token: access_token,
      access_token_secret: access_token_secret,
    ).user.id.to_s
  end
end

Rails.application.config.application_twitter_id = TwitterCredentials.create.twitter_uid
