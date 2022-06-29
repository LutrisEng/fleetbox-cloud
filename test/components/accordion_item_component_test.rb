# frozen_string_literal: true

require 'test_helper'

class AccordionItemComponentTest < ViewComponent::TestCase
  def test_component_renders_title
    render_inline(AccordionItemComponent.new(parent_id: 'parent', expanded: false, title: 'Hello, world!'))

    assert_selector('.accordion-button', text: 'Hello, world!')
  end

  def test_component_renders_body
    render_inline(AccordionItemComponent.new(parent_id: 'parent', expanded: false, title: 'Hello, world!')) do
      'Hello, body!'
    end

    assert_selector('.accordion-body', text: 'Hello, body!')
  end
end
