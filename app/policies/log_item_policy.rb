# frozen_string_literal: true

class LogItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.joins(:vehicle).merge(VehiclePolicy::Scope.new(user, Vehicle).resolve)
      end
    end
  end
end