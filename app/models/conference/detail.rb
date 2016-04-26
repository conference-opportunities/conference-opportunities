class Conference::Detail
  include ActiveModel::Model

  attr_accessor :conference, :location, :starts_at, :ends_at, :attendee_count
  validates :location, :starts_at, :ends_at, presence: true

  def id
    conference.twitter_handle
  end

  def persisted?
    true
  end

  def save
    return false unless valid?
    persist
    true
  end

  private

  def persist
    conference.update_attributes!(
      location: location,
      starts_at: starts_at,
      ends_at: ends_at,
      attendee_count: attendee_count,
    )
  end
end
