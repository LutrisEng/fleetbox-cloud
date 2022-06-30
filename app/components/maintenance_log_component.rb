# frozen_string_literal: true

class MaintenanceLogComponent < ViewComponent::Base
  def initialize(vehicle:, log_items: vehicle.log_items, create: true)
    super
    @vehicle = vehicle
    @log_items = log_items
    @create = create
  end
end
