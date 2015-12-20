class Tweet < ActiveRecord::Base
  belongs_to :conference
  validates :conference, presence: true
  validates :twitter_id, uniqueness: {scope: :conference_id}
end
