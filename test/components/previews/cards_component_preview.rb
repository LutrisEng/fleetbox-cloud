# frozen_string_literal: true

class CardsComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::TagHelper

  def empty
    render(CardsComponent.new)
  end

  def ten_varying_cards
    render(CardsComponent.new) do |c|
      (1..10).each do |i|
        c.with_card(image: i.multiple_of?(4) ? 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?q=75&fm=jpg&w=400&fit=max' : nil) do |card|
          card.with_body do
            accumulator = tag.h4 i.to_s
            (1..i).each do |j|
              accumulator += tag.p "iteration #{j}"
            end
            accumulator
          end
        end
      end
    end
  end
end
