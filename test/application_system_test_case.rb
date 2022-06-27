# frozen_string_literal: true

require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  DRIVER = if ENV['DRIVER']
             ENV['DRIVER'].to_sym
           else
             :chrome
           end
  driven_by :selenium, using: DRIVER, screen_size: [1400, 1400] do |driver_options|
    if ENV['FLEETBOX_DOCKER_TESTS']
      driver_options.add_argument('--no-sandbox')
      driver_options.add_argument('--disable-dev-shm-usage')
    end
  end
end
