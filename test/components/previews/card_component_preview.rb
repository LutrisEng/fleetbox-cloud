# frozen_string_literal: true

class CardComponentPreview < ViewComponent::Preview
  include ActionView::Helpers::TagHelper

  def body
    render(CardComponent.new) do |c|
      c.with_body { 'Hello, world!' }
    end
  end

  def header_and_footer
    render(CardComponent.new) do |c|
      c.with_header { 'New release!' }
      c.with_body { 'This is a super cool card!' }
      c.with_footer { 'Buy now!' }
    end
  end

  # @param image_url url
  # @param alt_text textarea
  def image(image_url: 'https://images.unsplash.com/photo-1462332420958-a05d1e002413?q=75&fm=jpg&w=400&fit=max', alt_text: '')
    render(CardComponent.new(image: image_url, image_alt: alt_text, classes: 'col-8 col-md-4')) do |c|
      c.with_body { 'This is a beautiful image.' }
    end
  end

  def buttons
    render(CardComponent.new) do |c|
      c.with_body do
        tag.p('Hello, world!') +
          tag.a('Click me!', href: '#', class: %w[btn btn-primary])
      end
    end
  end
end
