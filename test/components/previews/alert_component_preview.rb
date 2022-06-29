# frozen_string_literal: true

class AlertComponentPreview < ViewComponent::Preview
  def default
    render(AlertComponent.new) do
      'The vehicle has been successfully updated.'
    end
  end

  def dismissible
    render(AlertComponent.new(dismissible: true)) do
      'The vehicle has been successfully updated.'
    end
  end

  # @param dismissible toggle
  # @param color select [primary, secondary, success, danger, warning, info, light, dark]
  # @param body textarea
  def custom(dismissible: false, color: :primary, body: 'The vehicle has been successfully updated.')
    render(AlertComponent.new(dismissible:, color:)) do
      body
    end
  end
end
