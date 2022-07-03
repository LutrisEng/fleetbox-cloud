# frozen_string_literal: true

require 'test_helper'

class MaintenanceLogComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    vehicle = vehicles(:pipers_car)
    render_inline(MaintenanceLogComponent.new(vehicle:, log_items: vehicle.log_items))

    assert_text('Vehicle manufactured')
    assert_text('Break-in oil change')
    assert_text('Mounted summer tires')
  end
end
