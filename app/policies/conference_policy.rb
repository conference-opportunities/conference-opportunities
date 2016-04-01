class ConferencePolicy < ApplicationPolicy
  def update?
    user.conference == record
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.where.not(approved_at: nil)
    end
  end
end
