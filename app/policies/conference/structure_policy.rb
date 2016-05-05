class Conference::StructurePolicy < ApplicationPolicy
  def update?
    user.admin? || user.conference == record.conference
  end
end
