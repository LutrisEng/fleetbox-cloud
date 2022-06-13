# frozen_string_literal: true

require 'test_helper'

class OdometerReadingTest < ActiveSupport::TestCase
  test 'inherits owner from vehicle' do
    assert_equal(odometer_readings(:pipers_car_factory).owner, users(:piper))
  end
end
