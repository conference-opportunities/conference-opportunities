class Event < ActiveRecord::Base
  belongs_to :conference, inverse_of: :event

  geocoded_by :address
  after_validation :geocode, if: :should_geocode?

  private

  def should_geocode?
    return true if persisted? && address_changed?
    address? && !(latitude? && longitude?)
  end
end
