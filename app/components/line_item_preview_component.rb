# frozen_string_literal: true

class LineItemPreviewComponent < ViewComponent::Base
  def initialize(line_item:, mini: false, link: true)
    super
    @line_item = line_item
    @mini = mini
    @link = link
  end
end
