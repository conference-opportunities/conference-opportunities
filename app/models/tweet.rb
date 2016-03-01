class Tweet < ActiveRecord::Base
  belongs_to :conference
  validates :conference, presence: true
  validates :twitter_id, uniqueness: {scope: :conference_id, case_sensitive: false}

  def self.from_twitter(tweet)
    mentioned_handles = tweet.user_mentions.map(&:screen_name)
    Conference.where(twitter_handle: mentioned_handles)
              .map { |c| c.tweets.build(twitter_id: tweet.id) }
  end
end
