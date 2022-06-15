# frozen_string_literal: true

class VehiclePolicy < ApplicationPolicy
  def odometer?
    show?
  end

  class Scope < OwnerScope
  end
end
