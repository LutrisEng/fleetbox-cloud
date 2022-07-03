# frozen_string_literal: true

require 'test_helper'

class LineItemFieldPreviewComponentTest < ViewComponent::TestCase
  def test_renders_fixture_with_string
    render_inline(LineItemFieldPreviewComponent.new(line_item_field: line_item_fields(:pipers_car_breakin_oil_filter_part_number)))

    assert_text("What is the new oil filter's part number?")
    assert_text('11-42-8-583-898')
  end

  def test_renders_fixture_with_tire_set
    render_inline(LineItemFieldPreviewComponent.new(line_item_field: line_item_fields(:pipers_car_factory_tires)))

    assert_text('Which tire set was mounted?')
    assert_text('Bridgestone Turanza (??/??? ??)')
  end
end
