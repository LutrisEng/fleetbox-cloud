# frozen_string_literal: true

class VehicleDisplayNameComponent < ViewComponent::Base
  def initialize(vehicle:)
    @vehicle = vehicle
  end
end
