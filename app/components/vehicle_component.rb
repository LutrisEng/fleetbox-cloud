# frozen_string_literal: true

class VehicleComponent < ViewComponent::Base
  def initialize(vehicle:, current_user:, with_photo: false, with_title: true)
    super
    @vehicle = vehicle
    @current_user = current_user
    @with_photo = with_photo
    @with_title = with_title
  end
end
