# frozen_string_literal: true

class LogItemComponent < ViewComponent::Base
  def initialize(log_item:)
    super
    @log_item = log_item
  end
end
