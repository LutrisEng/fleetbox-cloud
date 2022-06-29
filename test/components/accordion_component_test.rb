# frozen_string_literal: true

require 'test_helper'

class AccordionComponentTest < ViewComponent::TestCase
  include ViewComponent::RenderPreviewHelper

  BUTTON_COLLAPSED = '.accordion-button.collapsed'
  BUTTON_EXPANDED = '.accordion-button:not(.collapsed)'
  BODY_COLLAPSED = '.accordion-collapse:not(.show) .accordion-body'
  BODY_EXPANDED = '.accordion-collapse.show .accordion-body'

  test 'preview with_single_collapsed_item renders properly' do
    render_preview(:with_single_collapsed_item)

    assert_selector(BUTTON_COLLAPSED, text: 'Item 1')
    assert_selector(BODY_COLLAPSED, text: 'Contents of item 1')
  end

  test 'preview with_many_collapsed_items renders properly' do
    render_preview(:with_many_collapsed_items)

    (1..10).each do |i|
      assert_selector(BUTTON_COLLAPSED, text: "Item #{i}")
      assert_selector(BODY_COLLAPSED, text: "Contents of item #{i}")
    end
  end

  test 'preview with_one_expanded_item renders properly' do
    render_preview(:with_one_expanded_item)

    assert_selector(BUTTON_EXPANDED, text: 'Item 1')
    assert_selector(BODY_EXPANDED, text: 'Contents of item 1')
  end

  test 'preview with_one_of_many_expanded renders properly' do
    render_preview(:with_one_of_many_expanded)

    (1..10).each do |i|
      assert_selector(i == 1 ? BUTTON_EXPANDED : BUTTON_COLLAPSED, text: "Item #{i}")
      assert_selector(i == 1 ? BODY_EXPANDED : BODY_COLLAPSED, text: "Contents of item #{i}")
    end
  end
end
