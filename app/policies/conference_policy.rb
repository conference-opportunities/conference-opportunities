class ConferencePolicy < Struct.new(:conference_organizer, :conference)
  def edit?
    conference_organizer.conference == conference
  end

  def show?
    conference.approved_at?
  end

  class Scope < Struct.new(:conference_organizer, :scope)
    def resolve
      scope.where.not(approved_at: nil)
    end
  end
end
