module Conferences
  class Detail
    include ActiveModel::Model

    attr_accessor :location, :starts_at, :ends_at, :conference
    validates :location, :starts_at, :ends_at, presence: true

    def save
      return false unless valid?
      persist
      true
    end

    def persist
      conference.update_attributes!(
        location: location,
        starts_at: starts_at,
        ends_at: ends_at,
      )
    end
  end
end
