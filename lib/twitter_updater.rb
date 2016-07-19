class TwitterUpdater < Struct.new(:consumer_key, :consumer_secret, :access_token, :access_token_secret)
  def self.authenticated
    new(
      TwitterCredentials.create.consumer_key,
      TwitterCredentials.create.consumer_secret,
      TwitterCredentials.create.access_token,
      TwitterCredentials.create.access_token_secret
    )
  end

  def update_conferences
    friends
      .map { |f| Conference.from_twitter_user(f) }
      .select(&:valid?)
      .each(&:save!)
    Conference.where.not(twitter_handle: friends.map(&:screen_name)).destroy_all
  end

  def update_tweets(since = 1)
    twitter_client.user_timeline(since_id: since)
      .flat_map { |t| Tweet.from_twitter(t) }
      .select(&:valid?)
      .each(&:save!)
  end

  private

  def friends(count = 100)
    @friends ||= twitter_client.friend_ids.each_slice(count).flat_map do |ids|
      twitter_client.users(ids)
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
