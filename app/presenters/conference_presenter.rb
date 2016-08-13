class ConferencePresenter
  attr_reader :conference

  delegate :tweets, :name, :logo_url, :banner_url, :location, :website_url, :description, to: :conference
  delegate :event, to: :conference, prefix: true
  delegate :starts_at, :ends_at, :call_for_proposals_ends_at, :speaker_notifications_at, to: :conference_event, allow_nil: true
  delegate :call_for_proposals_url, :code_of_conduct_url, to: :conference_event, allow_nil: true
  delegate :has_childcare, :has_diversity_scholarships, :has_honorariums, :has_lodging_funding, :has_travel_funding, to: :conference_event, allow_nil: true

  def initialize(conference)
    @conference = conference
  end

  def twitter_name
    "@#{conference.twitter_handle}"
  end

  def twitter_url
    "https://twitter.com/#{conference.twitter_handle}"
  end

  def hashtag
    "##{conference_event.hashtag}" if conference_event
  end
end
