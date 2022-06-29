# frozen_string_literal: true

# @label Accordion
class AccordionComponentPreview < ViewComponent::Preview
  # 1 collapsed item
  # ----------------
  # This accordion has a single item, and that one item is collapsed.
  #
  # @label 1 collapsed
  def one_collapsed
    render(AccordionComponent.new) do |c|
      c.with_item(expanded: false, title: 'Item 1') { 'Contents of item 1' }
    end
  end

  # 10 collapsed items
  # ------------------
  # This accordion has 10 items, all of which are collapsed.
  #
  # @label 10 collapsed
  def ten_collapsed
    render(AccordionComponent.new) do |c|
      (1..10).each do |i|
        c.with_item(expanded: false, title: "Item #{i}") { "Contents of item #{i}" }
      end
    end
  end

  # 1 expanded item
  # ---------------
  # This accordion has a single item, and that one item is expanded.
  #
  # @label 1 expanded
  def one_expanded
    render(AccordionComponent.new) do |c|
      c.with_item(expanded: true, title: 'Item 1') { 'Contents of item 1' }
    end
  end

  # 1 expanded item + 9 collapsed items
  # ---------------
  # This accordion has a single expanded item at the top, and 9 collapsed items
  # underneath.
  #
  # @label 1 expanded, 9 collapsed
  def one_expanded_nine_collapsed
    render(AccordionComponent.new) do |c|
      (1..10).each do |i|
        c.with_item(expanded: i == 1, title: "Item #{i}") { "Contents of item #{i}" }
      end
    end
  end

  # 1 expanded item + n collapsed items
  # ---------------
  # This accordion has a single expanded item at the top, and n collapsed items
  # underneath.
  #
  # @label 1 expanded, n collapsed
  # @param collapsed_items number
  def one_expanded_n_collapsed(collapsed_items: 9)
    render(AccordionComponent.new) do |c|
      (1..(collapsed_items + 1)).each do |i|
        c.with_item(expanded: i == 1, title: "Item #{i}") { "Contents of item #{i}" }
      end
    end
  end
end
