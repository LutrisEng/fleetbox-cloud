# frozen_string_literal: true

class TireSetPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.where(owner: user)
      end
    end
  end
end
