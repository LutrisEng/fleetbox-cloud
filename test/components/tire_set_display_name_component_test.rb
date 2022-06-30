# frozen_string_literal: true

require 'test_helper'

class TireSetDisplayNameComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    render_inline(TireSetDisplayNameComponent.new(tire_set: tire_sets(:pipers_summer_tires)))
    assert_text('Michelin Pilot Sport 4S')
  end
end
