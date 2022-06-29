# frozen_string_literal: true

class AccordionComponent < ViewComponent::Base
  renders_many :items, lambda { |expanded:, title:, &block|
    AccordionItemComponent.new(parent_id: @id, expanded:, title:, &block)
  }

  def initialize
    super
    @id = "accordion_#{SecureRandom.hex(5)}"
  end
end
