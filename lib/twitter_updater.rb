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
    friends
      .map { |f| Conference.from_twitter_user(f) }
      .select(&:valid?)
      .each(&:save!)
  end

  def update_tweets(since = 1)
    twitter_client.user_timeline(since_id: since)
      .flat_map { |t| Tweet.from_twitter(t) }
      .select(&:valid?)
      .each(&:save!)
  end

  private

  def friends(count = 100)
    twitter_client.friend_ids.each_slice(count).flat_map do |friend_ids|
      twitter_client.users(friend_ids)
    end
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = consumer_key
      config.consumer_secret = consumer_secret
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end
end
