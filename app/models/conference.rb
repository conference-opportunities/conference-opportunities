class Conference < ActiveRecord::Base
  validates :twitter_handle, presence: true, uniqueness: true
  has_many :tweets, dependent: :destroy

  def self.from_twitter_user(user)
    new(
      twitter_handle: user.screen_name,
      name: user.name,
      logo_url: user.profile_image_url_https,
      location: user.location,
      website_url: user.website,
      description: user.description,
    )
  end

  def to_param
    twitter_handle
  end
end
