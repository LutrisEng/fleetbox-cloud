# frozen_string_literal: true

class TireSetPolicy < ApplicationPolicy
  class Scope < OwnerScope
  end
end
