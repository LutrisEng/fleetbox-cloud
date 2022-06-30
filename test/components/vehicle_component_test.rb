# frozen_string_literal: true

require 'test_helper'

class VehicleComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    render_inline(VehicleComponent.new(vehicle: vehicles(:pipers_car), current_user: users(:piper)))
    assert_text("Piper's Car")
    assert_text('2022')
    assert_text('BMW')
    assert_text('M340i')
  end
end
