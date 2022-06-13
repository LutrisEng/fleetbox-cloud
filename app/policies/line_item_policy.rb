# frozen_string_literal: true

class LineItemPolicy < ApplicationPolicy
  class Scope < OwnerScope
  end
end
