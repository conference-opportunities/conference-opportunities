class Conference::Listing
  include ActiveModel::Model

  attr_accessor :name, :website_url, :logo_url, :conference
  validates :name, presence: true

  def id
    conference.twitter_handle
  end

  def twitter_handle
    conference.twitter_handle
  end

  def save
    return false unless valid?
    persist
    true
  end

  private

  def persist
    conference.update_attributes!(
      name: name,
      website_url: website_url,
      logo_url: logo_url,
      approved_at: Time.now
    )
  end
end
