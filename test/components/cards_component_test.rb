# frozen_string_literal: true

require 'test_helper'

class CardsComponentTest < ViewComponent::TestCase
  include ViewComponent::RenderPreviewHelper

  test 'empty renders' do
    render_preview :empty
  end
end
