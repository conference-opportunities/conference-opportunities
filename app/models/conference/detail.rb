class Conference::Detail
  include ActiveModel::Model

  attr_accessor :conference, :location, :starts_at, :ends_at, :attendee_count

  validates :location, presence: true
  validates :attendee_count, numericality: {allow_blank: true}
  validates :starts_at, timeliness: true
  validates :ends_at, timeliness: {after_or_equal_to: :starts_at}

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
    event = conference.event || conference.build_event
    event.update_attributes!(
      address: location,
      starts_at: starts_at,
      ends_at: ends_at,
      attendees_count: attendee_count,
      call_for_proposals_ends_at: starts_at,
      speaker_notifications_at: starts_at,
    )
  end
end
