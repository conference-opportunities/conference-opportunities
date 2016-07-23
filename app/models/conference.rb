class Conference < ActiveRecord::Base
  validates :twitter_handle, :uid, presence: true, uniqueness: { case_sensitive: false }
  has_many :tweets, dependent: :destroy

  def self.from_twitter_user(user)
    Conference.find_or_initialize_by(uid: user.id).update_from_twitter(user)
  end

  def update_from_twitter(user)
    assign_attributes(
      description: user.description,
      location: user.location,
      logo_url: user.profile_image_url_https,
      name: user.name,
      twitter_handle: user.screen_name,
      website_url: user.website
    )
    self
  end

  def to_param
    twitter_handle
  end
end
