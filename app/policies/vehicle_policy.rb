# frozen_string_literal: true

class VehiclePolicy < ApplicationPolicy
  def odometer?
    show?
  end

  def create?
    user&.can_create_vehicle?
  end

  def new?
    create?
  end

  class Scope < OwnerScope
  end
end
