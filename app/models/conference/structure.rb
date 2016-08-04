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

  attr_accessor :conference

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
    )
  end
end
