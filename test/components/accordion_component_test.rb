# frozen_string_literal: true

require 'test_helper'

class AccordionComponentTest < ViewComponent::TestCase
  include ViewComponent::RenderPreviewHelper

  BUTTON_COLLAPSED = '.accordion-button.collapsed'
  BUTTON_EXPANDED = '.accordion-button:not(.collapsed)'
  BODY_COLLAPSED = '.accordion-collapse:not(.show) .accordion-body'
  BODY_EXPANDED = '.accordion-collapse.show .accordion-body'

  test 'preview with 1 collapsed item renders properly' do
    render_preview(:one_collapsed)

    assert_selector(BUTTON_COLLAPSED, text: 'Item 1')
    assert_selector(BODY_COLLAPSED, text: 'Contents of item 1')
  end

  test 'preview with 10 collapsed items renders properly' do
    render_preview(:ten_collapsed)

    (1..10).each do |i|
      assert_selector(BUTTON_COLLAPSED, text: "Item #{i}")
      assert_selector(BODY_COLLAPSED, text: "Contents of item #{i}")
    end
  end

  test 'preview with 1 expanded item renders properly' do
    render_preview(:one_expanded)

    assert_selector(BUTTON_EXPANDED, text: 'Item 1')
    assert_selector(BODY_EXPANDED, text: 'Contents of item 1')
  end

  test 'preview 1 expanded item and 9 collapsed items renders properly' do
    render_preview(:one_expanded_nine_collapsed)

    (1..10).each do |i|
      assert_selector(i == 1 ? BUTTON_EXPANDED : BUTTON_COLLAPSED, text: "Item #{i}")
      assert_selector(i == 1 ? BODY_EXPANDED : BODY_COLLAPSED, text: "Contents of item #{i}")
    end
  end
end
