# frozen_string_literal: true

require 'test_helper'

class CardComponentTest < ViewComponent::TestCase
  include ViewComponent::RenderPreviewHelper

  test 'body renders' do
    render_preview :body
  end

  test 'header and footer renders' do
    render_preview :header_and_footer
  end

  test 'image renders' do
    render_preview :image
  end

  test 'button renders' do
    render_preview :buttons
  end
end
