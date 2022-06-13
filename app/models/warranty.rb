# frozen_string_literal: true

class Warranty < ApplicationRecord
  belongs_to :vehicle, optional: true
  belongs_to :tire_set, optional: true
  validate :must_have_one_parent

  owner_from_parents [{ name: :vehicle, klass: Vehicle }, { name: :tire_set, klass: TireSet }]

  def must_have_one_parent
    errors.add_to_base('Must have exactly one parent (vehicle XOR tire set)') unless (!vehicle.nil?) ^ (!tire_set.nil?)
  end
end
