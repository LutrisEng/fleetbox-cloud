# frozen_string_literal: true

require "test_helper"

class VersionComponentTest < ViewComponent::TestCase
  include ViewComponent::RenderPreviewHelper

  def test_default
    render_preview(:default)

    assert_text('fleetbox-cloud')
    assert_text(FLEETBOX_VERSION)
    assert_link('view source code', href: "https://github.com/lutriseng/fleetbox-cloud/tree/#{FLEETBOX_COMMIT}")
    assert_text("#{FLEETBOX_VERSION}, test environment (view source code)")
    assert_text('This program is free software')
    assert_text(Time.current.year.to_s)
  end
end
