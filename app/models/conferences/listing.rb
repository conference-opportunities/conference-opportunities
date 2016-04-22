module Conferences
  class Listing
    include ActiveModel::Model

    attr_accessor :name, :website_url, :conference
    validates :name, presence: true

    def save
      return false unless valid?
      persist
      true
    end

    def persist
      conference.update_attributes!(
        name: name,
        website_url: website_url,
        approved_at: Time.now
      )
    end
  end
end
