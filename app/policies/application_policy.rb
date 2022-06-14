# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def admin?
    user.admin
  end

  def owner?
    !user.nil? && record.owner == user
  end

  def admin_or_owner?
    admin? || owner?
  end

  def index?
    admin_or_owner?
  end

  def show?
    admin_or_owner?
  end

  def create?
    admin_or_owner?
  end

  def new?
    true
  end

  def update?
    admin_or_owner?
  end

  def edit?
    update?
  end

  def destroy?
    admin_or_owner?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end

  class OwnerScope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.where_owner(user)
      end
    end
  end
end
