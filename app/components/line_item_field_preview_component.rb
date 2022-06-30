# frozen_string_literal: true

class LineItemFieldPreviewComponent < ViewComponent::Base
  def initialize(line_item_field:, link: true)
    super
    @line_item_field = line_item_field
    @link = link
  end
end
