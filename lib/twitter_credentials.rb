require 'twitter'

class TwitterCredentials < Struct.new(:consumer_key, :consumer_secret, :access_token, :access_token_secret)
  def self.create(environment = ENV)
    new(*environment.values_at('TWITTER_CONSUMER_KEY', 'TWITTER_CONSUMER_SECRET', 'TWITTER_ACCESS_TOKEN', 'TWITTER_ACCESS_TOKEN_SECRET'))
  end

  def twitter_uid(env = Rails.env)
    return 'FAKE_TWITTER_UID' if env.test? || ![consumer_key, consumer_secret, access_token, access_token_secret].all?
    client.user.id.to_s
  end

  def client(client_class = Twitter::REST::Client)
    client_class.new(self.to_h)
  end
end
