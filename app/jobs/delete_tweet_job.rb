class DeleteTweetJob < ActiveJob::Base
  queue_as :default

  def self.from_event(tweet)
    perform_later(tweet.id)
  end

  def perform(tweet_id)
    Tweet.where(twitter_id: tweet_id).destroy_all
  end
end
