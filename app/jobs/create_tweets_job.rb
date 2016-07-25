class CreateTweetsJob < ActiveJob::Base
  queue_as :default

  def perform
    last_tweet = Tweet.last || NullTweet.new
    since = last_tweet.twitter_id.to_i
    tweets = TwitterCredentials.create.client.user_timeline(since_id: since)
    tweets.flat_map { |tweet| CreateTweetJob.from_event(tweet) }
  end
end
