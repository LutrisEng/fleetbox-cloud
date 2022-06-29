# frozen_string_literal: true

require 'test_helper'

class AlertComponentTest < ViewComponent::TestCase
  include ViewComponent::RenderPreviewHelper

  test 'default preview renders' do
    render_preview(:default)
  end

  test 'renders with each color' do
    AlertComponent::COLORS.each do |color|
      render_inline(AlertComponent.new(color:)) do
        'The vehicle has been successfully updated.'
      end
    end
  end
end
