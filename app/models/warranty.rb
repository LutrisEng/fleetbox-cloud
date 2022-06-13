# frozen_string_literal: true

class Warranty < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :tire_set, optional: true
  validate :must_have_one_parent

  scope :with_owner, lambda { |owner|
    joined = left_joins(:vehicle).left_joins(:tire_set)
    joined.merge(Vehicle.with_owner(owner)).or(
      joined.merge(TireSet.with_owner(owner))
    )
  }

  def must_have_one_parent
    errors.add_to_base('Must have exactly one parent (vehicle XOR tire set)') unless (!vehicle.nil?) ^ (!tire_set.nil?)
  end
end
