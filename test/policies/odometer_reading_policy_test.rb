# frozen_string_literal: true

require 'test_helper'

class OdometerReadingPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    user = users(:piper)
    user.admin = false
    odometer_readings = OdometerReadingPolicy::Scope.new(user, OdometerReading).resolve
    assert(odometer_readings.include?(odometer_readings(:pipers_car_factory)))
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
