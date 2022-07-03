# frozen_string_literal: true

require 'test_helper'

class LineItemPreviewComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    render_inline(LineItemPreviewComponent.new(line_item: line_items(:pipers_car_factory_transmission_fluid_filter)))

    assert_text('Transmission fluid filter replaced')
  end
end
