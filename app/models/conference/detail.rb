class Conference::Detail
  include ActiveModel::Model

  attr_accessor :conference, :location, :starts_at, :ends_at, :attendee_count
  validates :location, presence: true
  validates :attendee_count, numericality: {allow_nil: true}
  validates :starts_at, date: true
  validates :ends_at, date: {after_or_equal_to: :starts_at}

  class DateExtractor < Struct.new(:value)
    def extract
      Date.parse(value)
    rescue ArgumentError
      nil
    rescue TypeError
      value
    end
  end

  def attendee_count=(count)
    @attendee_count = count.presence
  end

  def starts_at=(date)
    @starts_at = DateExtractor.new(date).extract
  end

  def ends_at=(date)
    @ends_at = DateExtractor.new(date).extract
  end

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
