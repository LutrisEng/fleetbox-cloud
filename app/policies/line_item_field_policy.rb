# frozen_string_literal: true

class LineItemFieldPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.joins(:line_item).merge(LineItemPolicy::Scope.new(user, LineItem).resolve)
      end
    end
  end
end
