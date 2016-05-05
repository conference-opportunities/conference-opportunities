class Conference::ListingPolicy < ApplicationPolicy
  def create?
    user.admin? || user.conference == record.conference
  end
end
