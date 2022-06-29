# frozen_string_literal: true

class AccordionItemComponent < ViewComponent::Base
  def initialize(parent_id:, expanded:, title:)
    super
    @parent_id = parent_id
    @id = "accordion_item_#{SecureRandom.hex(5)}"
    @expanded = expanded || false
    @title = title
  end
end
