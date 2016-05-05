class Conference::Structure
  include ActiveModel::Model
  include Virtus.model(:nullify_blank => true)

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
    attribute count_field, Integer
    validates count_field, numericality: {allow_nil: true, only_integer: true, greater_than_or_equal_to: 0}
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
    conference.update_attributes!(
      track_count: track_count,
      plenary_count: plenary_count,
      tutorial_count: tutorial_count,
      workshop_count: workshop_count,
      keynote_count: keynote_count,
      talk_count: talk_count,
      other_count: other_count,
      cfp_count: cfp_count,
      prior_submissions_count: prior_submissions_count,
      panel_count: panel_count,
    )
  end
end
