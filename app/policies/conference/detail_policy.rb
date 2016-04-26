class Conference::DetailPolicy < ApplicationPolicy
  def update?
    user.conference == record.conference
  end
end
