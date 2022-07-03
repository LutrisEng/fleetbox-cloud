# frozen_string_literal: true

require 'test_helper'

class LogItemPreviewComponentTest < ViewComponent::TestCase
  def test_renders_fixture
    render_inline(LogItemPreviewComponent.new(log_item: log_items(:pipers_car_factory)))

    # Display name
    assert_text('Vehicle manufactured')
    # Shop
    assert_text('BMW')
    # Odometer reading
    assert_text('0 miles')
    # Line item
    assert_text('Transmission fluid filter replaced')
  end
end
