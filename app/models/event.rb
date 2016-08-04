class Event < ActiveRecord::Base
  belongs_to :conference, inverse_of: :event

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  def self.approved
    joins(:conference).merge(Conference.approved)
  end

  def self.followed
    joins(:conference).merge(Conference.followed)
  end
end
