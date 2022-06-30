# frozen_string_literal: true

require 'test_helper'

class VehicleDisplayNameComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    render_inline(VehicleDisplayNameComponent.new(vehicle: vehicles(:pipers_car)))
    assert_text("Piper's Car")
  end
end
