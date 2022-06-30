# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  renders_one :header
  renders_one :body
  renders_one :footer

  def initialize(image: nil, image_alt: nil, classes: nil)
    super
    @image = image
    @image_alt = image_alt
    @classes = classes
  end
end
