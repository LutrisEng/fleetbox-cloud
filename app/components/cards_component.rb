# frozen_string_literal: true

class CardsComponent < ViewComponent::Base
  renders_many :cards, CardComponent
end
