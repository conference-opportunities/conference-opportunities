class ConferencePolicy < Struct.new(:conference_organizer, :conference)
  def edit?
    conference_organizer.conference == conference
  end
end
