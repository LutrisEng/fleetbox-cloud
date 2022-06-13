# frozen_string_literal: true

class LineItemPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin
        scope.all
      else
        scope.joins(:log_item).merge(LogItemPolicy::Scope.new(user, LogItem).resolve)
      end
    end
  end
end
