# frozen_string_literal: true

class AccordionComponentPreview < ViewComponent::Preview
  def with_single_collapsed_item
    render(AccordionComponent.new) do |c|
      c.with_item(expanded: false, title: 'Item 1') { 'Contents of item 1' }
    end
  end

  def with_many_collapsed_items
    render(AccordionComponent.new) do |c|
      (1..10).each do |i|
        c.with_item(expanded: false, title: "Item #{i}") { "Contents of item #{i}" }
      end
    end
  end

  def with_one_expanded_item
    render(AccordionComponent.new) do |c|
      c.with_item(expanded: true, title: 'Item 1') { 'Contents of item 1' }
    end
  end

  def with_one_of_many_expanded
    render(AccordionComponent.new) do |c|
      (1..10).each do |i|
        c.with_item(expanded: i == 1, title: "Item #{i}") { "Contents of item #{i}" }
      end
    end
  end
end
