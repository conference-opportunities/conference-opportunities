class Conference::Structure
  include ActiveModel::Model

  COUNTS = %i[
    track_count
    plenary_count
    tutorial_count
    workshop_count
    keynote_count
    talk_count
    other_count
    cfp_count
    prior_submissions_count
    panel_count
  ]

  COUNTS.each do |count_field|
    attr_accessor count_field
    validates count_field, numericality: {allow_blank: true, only_integer: true, greater_than_or_equal_to: 0}
  end

  attr_accessor :cfp_url, :code_of_conduct_url, :hashtag
  validates :cfp_url, :code_of_conduct_url, :hashtag, presence: true

  attr_accessor :has_childcare, :has_diversity_scholarships, :has_honorariums, :has_lodging_funding, :has_travel_funding
  validates :has_childcare, :has_diversity_scholarships, :has_honorariums, :has_lodging_funding, :has_travel_funding, presence: true

  attr_accessor :conference

  def id
    conference.twitter_handle
  end

  def default_hashtag
    conference.event.hashtag || conference.twitter_handle
  end

  def default_call_for_proposals_url
    conference.event.call_for_proposals_url || conference.website_url
  end

  def default_code_of_conduct_url
    conference.event.code_of_conduct_url || conference.website_url
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
    conference.event.update_attributes!(
      tracks_count: track_count,
      plenaries_count: plenary_count,
      tutorials_count: tutorial_count,
      workshops_count: workshop_count,
      keynotes_count: keynote_count,
      talks_count: talk_count,
      other_talks_count: other_count,
      submission_opportunities_count: cfp_count,
      prior_submissions_count: prior_submissions_count,
      panels_count: panel_count,
      call_for_proposals_url: cfp_url,
      code_of_conduct_url: code_of_conduct_url,
      hashtag: hashtag,
      has_childcare: has_childcare,
      has_diversity_scholarships: has_diversity_scholarships,
      has_honorariums: has_honorariums,
      has_lodging_funding: has_lodging_funding,
      has_travel_funding: has_travel_funding,
    )
  end
end
