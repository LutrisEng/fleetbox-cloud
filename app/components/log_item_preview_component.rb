# frozen_string_literal: true

class LogItemPreviewComponent < ViewComponent::Base
  def initialize(log_item:)
    super
    @log_item = log_item
  end
end
