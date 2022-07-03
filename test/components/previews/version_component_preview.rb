# frozen_string_literal: true

class VersionComponentPreview < ViewComponent::Preview
  def default
    render(VersionComponent.new)
  end
end
