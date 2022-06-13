# frozen_string_literal: true

class WarrantyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        joined = scope.left_joins(:vehicle).left_joins(:tire_set)
        joined.merge(VehiclePolicy::Scope.new(user, Vehicle).resolve).or(
          joined.merge(TireSetPolicy::Scope.new(user, TireSet).resolve)
        )
      end
    end
  end
end
