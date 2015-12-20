class Tweet < ActiveRecord::Base
  belongs_to :conference
  validates :conference, presence: true
end
