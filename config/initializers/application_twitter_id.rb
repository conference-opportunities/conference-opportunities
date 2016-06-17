class TwitterCredentials
  if Rails.env.production?
    CONSUMER_KEY = ENV.fetch("TWITTER_CONSUMER_KEY")
    CONSUMER_SECRET = ENV.fetch("TWITTER_CONSUMER_SECRET")
    ACCESS_TOKEN = ENV.fetch("TWITTER_ACCESS_TOKEN")
    ACCESS_TOKEN_SECRET = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    def self.twitter_uid
      Twitter::REST::Client.new(
        consumer_key: TwitterCredentials::CONSUMER_KEY,
        consumer_secret: TwitterCredentials::CONSUMER_SECRET,
        access_token: TwitterCredentials::ACCESS_TOKEN,
        access_token_secret: TwitterCredentials::ACCESS_TOKEN_SECRET,
      ).user.id.to_s
    end
  else
    CONSUMER_KEY = "FAKE_TWITTER_CONSUMER_KEY"
    CONSUMER_SECRET = "FAKE_TWITTER_CONSUMER_SECRET"
    ACCESS_TOKEN = "FAKE_TWITTER_ACCESS_TOKEN"
    ACCESS_TOKEN_SECRET = "FAKE_TWITTER_ACCESS_TOKEN_SECRET"
    def self.twitter_uid
      "FAKE_TWITTER_UID"
    end
  end
end

Rails.application.config.application_twitter_id = TwitterCredentials.twitter_uid
