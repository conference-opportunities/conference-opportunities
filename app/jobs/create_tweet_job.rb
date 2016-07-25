class CreateTweetJob < ActiveJob::Base
  queue_as :default

  def self.from_event(tweet)
    perform_later(tweet.id, tweet.user_mentions.map(&:id))
  end

  def perform(tweet_id, mentioned_user_ids)
    conferences = Conference.where(uid: mentioned_user_ids)
    conferences.map { |c| c.tweets.build(twitter_id: tweet_id) }.each(&:save)
  end
end
