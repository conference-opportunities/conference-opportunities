class Conference < ActiveRecord::Base
  has_one :event, dependent: :destroy, inverse_of: :conference
  has_many :tweets, dependent: :destroy

  validates :twitter_handle, :uid, presence: true, uniqueness: {case_sensitive: false}

  def self.followed
    where(unfollowed_at: nil)
  end

  def self.approved
    where.not(approved_at: nil)
  end

  def self.from_twitter_user(user)
    Conference.find_or_initialize_by(uid: user.id).update_from_twitter(user)
  end

  def update_from_twitter(user)
    assign_attributes(
      description: user.description,
      location: user.location,
      logo_url: user.profile_image_uri_https(:original),
      banner_url: user.profile_banner_uri_https(:web_retina),
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
