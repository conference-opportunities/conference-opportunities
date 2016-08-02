class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def dashboard?
    user.present? && user.admin?
  end

  def show_in_app?
    user.present? && user.admin?
  end

  def export?
    user.present? && user.admin?
  end

  def index?
    user.present?
  end

  def show?
    scope.where(id: record.id).exists? && user.present?
  end

  def create?
    user.present? && user.admin?
  end

  def new?
    create?
  end

  def update?
    user.present? && user.admin?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
