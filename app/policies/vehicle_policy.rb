# frozen_string_literal: true

class VehiclePolicy < ApplicationPolicy
  class Scope < OwnerScope
  end
end
