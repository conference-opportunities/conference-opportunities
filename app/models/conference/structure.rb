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
    conference.update_attributes!(
      track_count: track_count.try(&:to_i),
      plenary_count: plenary_count.try(&:to_i),
      tutorial_count: tutorial_count.try(&:to_i),
      workshop_count: workshop_count.try(&:to_i),
      keynote_count: keynote_count.try(&:to_i),
      talk_count: talk_count.try(&:to_i),
      other_count: other_count.try(&:to_i),
      cfp_count: cfp_count.try(&:to_i),
      prior_submissions_count: prior_submissions_count.try(&:to_i),
      panel_count: panel_count.try(&:to_i),
    )
  end
end
