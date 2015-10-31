class TwitterUpdater < Struct.new(:consumer_key, :consumer_secret, :access_token, :access_token_secret)
  def self.authenticated
    new(
      ENV.fetch("TWITTER_CONSUMER_KEY"),
      ENV.fetch("TWITTER_CONSUMER_SECRET"),
      ENV.fetch("TWITTER_ACCESS_TOKEN"),
      ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    )
  end

  def update_conferences
    twitter_client.friends
      .map { |f| Conference.from_twitter_user(f) }
      .select(&:valid?)
      .each(&:save!)
  end

  private

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = consumer_key
      config.consumer_secret = consumer_secret
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end
end
