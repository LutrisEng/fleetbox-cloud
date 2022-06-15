# frozen_string_literal: true

require 'test_helper'

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle = vehicles(:pipers_car)
  end

  test 'should get index' do
    get vehicles_url
    assert_response :success
  end

  test 'should get new' do
    get new_vehicle_url
    assert_response :success
  end

  test 'should create vehicle' do
    assert_difference('Vehicle.count') do
      post vehicles_url,
           params: { vehicle: { breakin: @vehicle.breakin, display_name: @vehicle.display_name, make: @vehicle.make,
                                miles_per_year: @vehicle.miles_per_year, model: @vehicle.model, model_year: @vehicle.model_year, vin: 'insert random vin' } }
    end

    assert_redirected_to vehicle_url(Vehicle.last)
  end

  test 'should show vehicle' do
    get vehicle_url(@vehicle)
    assert_response :success
  end

  test 'should show vehicle odometer' do
    get odometer_vehicle_url(@vehicle)
    assert_response :success
  end

  test 'should get edit' do
    get edit_vehicle_url(@vehicle)
    assert_response :success
  end

  test 'should update vehicle' do
    patch vehicle_url(@vehicle),
          params: { vehicle: { breakin: @vehicle.breakin, display_name: @vehicle.display_name, make: @vehicle.make,
                               miles_per_year: (@vehicle.miles_per_year || 0) + 500, model: 'some other model', model_year: @vehicle.model_year, vin: @vehicle.vin } }
    assert_redirected_to vehicle_url(@vehicle)
  end

  test 'should destroy vehicle' do
    @vehicle = Vehicle.create(owner: users(:piper))

    assert_difference('Vehicle.count', -1) do
      delete vehicle_url(@vehicle)
    end

    assert_redirected_to vehicles_url
  end
end
