class Tweet < ActiveRecord::Base
  belongs_to :conference
  validates :conference, presence: true
  validates :twitter_id, uniqueness: {scope: :conference_id, case_sensitive: false}

  def self.from_twitter(tweet)
    mentioned_users = tweet.user_mentions.map(&:id)
    Conference.where(uid: mentioned_users)
              .map { |c| c.tweets.build(twitter_id: tweet.id) }
  end
end
