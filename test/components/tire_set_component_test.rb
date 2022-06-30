# frozen_string_literal: true

require 'test_helper'

class TireSetComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    render_inline(TireSetComponent.new(tire_set: tire_sets(:pipers_summer_tires), current_user: users(:piper)))
    assert_text('Michelin Pilot Sport 4S')
  end
end
