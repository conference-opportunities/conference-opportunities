class ConferencePolicy < Struct.new(:organizer, :conference)
  def edit?
    organizer.conference == conference
  end

  def show?
    conference.approved_at?
  end

  class Scope < Struct.new(:organizer, :scope)
    def resolve
      scope.where.not(approved_at: nil)
    end
  end
end
