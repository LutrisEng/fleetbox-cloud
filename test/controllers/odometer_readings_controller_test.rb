
# frozen_string_literal: true

require 'test_helper'

class OdometerReadingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle = vehicles(:pipers_car)
  end

  test 'should get index' do
    get vehicle_odometer_readings_url(@vehicle)
    assert_response :success
  end

  test 'should create odometer reading' do
    assert_difference('OdometerReading.count') do
      post vehicle_odometer_readings_url(@vehicle),
           params: { odometer_reading: { reading: 100_000, performed_at: Time.now.utc } }
    end

    assert_equal 100_000, @vehicle.odometer
    assert_redirected_to vehicle_odometer_readings_url(@vehicle)
  end

  test 'should get edit' do
    get edit_vehicle_odometer_reading_url(@vehicle, @vehicle.odometer_readings.first)
    assert_response :success
  end

  test 'should update odometer reading' do
    patch vehicle_odometer_reading_url(@vehicle, @vehicle.odometer_readings.chrono.last),
          params: { odometer_reading: { reading: 900_000 } }

    assert_equal 900_000, @vehicle.odometer
    assert_redirected_to edit_vehicle_odometer_reading_url(@vehicle, @vehicle.odometer_readings.chrono.last)
  end

  test 'should destroy odometer reading' do
    @vehicle = Vehicle.create(owner: users(:piper))
    @odometer_reading = OdometerReading.create(vehicle: @vehicle, reading: 100_000, performed_at: Time.now.utc)

    assert_difference('OdometerReading.count', -1) do
      delete vehicle_odometer_reading_url(@vehicle, @odometer_reading)
    end

    assert_redirected_to vehicle_odometer_readings_url
  end
end
