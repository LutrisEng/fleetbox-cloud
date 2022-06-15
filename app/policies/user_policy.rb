# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def me?
    show?
  end

  def update_me?
    update?
  end

  class Scope < OwnerScope
  end
end
