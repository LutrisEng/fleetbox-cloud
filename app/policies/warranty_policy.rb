# frozen_string_literal: true

class WarrantyPolicy < ApplicationPolicy
  class Scope < OwnerScope
  end
end
