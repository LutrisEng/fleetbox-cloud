# frozen_string_literal: true

class ShopPolicy < ApplicationPolicy
  class Scope < OwnerScope
  end
end
