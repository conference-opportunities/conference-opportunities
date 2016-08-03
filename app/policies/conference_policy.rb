class ConferencePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true if user.present? && user.conference == record
    scope.where(id: record.id).exists?
  end

  def update?
    return false if user.nil?
    user.admin? || user.conference == record
  end

  class Scope < ApplicationPolicy::Scope
    def resolve
      return scope.all if user.present? && user.admin?
      scope.followed.approved
    end
  end
end
