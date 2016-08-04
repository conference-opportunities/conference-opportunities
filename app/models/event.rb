class Event < ActiveRecord::Base
  belongs_to :conference, inverse_of: :event

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
