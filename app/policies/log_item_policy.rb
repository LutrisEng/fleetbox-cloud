# frozen_string_literal: true

class LogItemPolicy < ApplicationPolicy
  class Scope < OwnerScope
  end
end
