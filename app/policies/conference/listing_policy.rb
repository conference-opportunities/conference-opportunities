class Conference::ListingPolicy < ApplicationPolicy
  def create?
    user.conference == record.conference
  end
end
