# frozen_string_literal: true

require 'application_system_test_case'

class VehiclesTest < ApplicationSystemTestCase
  setup do
    @vehicle = vehicles(:pipers_car)
  end

  test 'visiting the index' do
    visit vehicles_url
    assert_selector 'h1', text: 'My vehicles'
  end

  test 'should create vehicle' do
    visit vehicles_url
    click_on 'New Vehicle'

    fill_in 'Break-in period', with: @vehicle.breakin
    fill_in 'Display name', with: @vehicle.display_name
    fill_in 'Make', with: @vehicle.make
    fill_in 'Approximate miles driven per year', with: @vehicle.miles_per_year
    fill_in 'Model', with: @vehicle.model
    fill_in 'Model year', with: @vehicle.model_year
    fill_in 'VIN', with: @vehicle.vin
    click_on 'Create Vehicle'

    assert_text 'Vehicle was successfully created'
    click_on 'Back'
  end

  test 'should update Vehicle' do
    visit vehicle_url(@vehicle)
    click_on 'Edit Vehicle', match: :first

    fill_in 'Break-in period', with: @vehicle.breakin
    fill_in 'Display name', with: @vehicle.display_name
    fill_in 'Make', with: @vehicle.make
    fill_in 'Approximate miles driven per year', with: @vehicle.miles_per_year
    fill_in 'Model', with: @vehicle.model
    fill_in 'Model year', with: @vehicle.model_year
    fill_in 'VIN', with: @vehicle.vin
    click_on 'Update Vehicle'

    assert_text 'Vehicle was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Vehicle' do
    @vehicle = Vehicle.create(owner: users(:piper))

    visit vehicle_url(@vehicle)
    click_on 'Destroy Vehicle', match: :first

    assert_text 'Vehicle was successfully destroyed'
  end

  test 'should add odometer reading' do
    @vehicle = Vehicle.create(owner: users(:piper))

    visit odometer_vehicle_url(@vehicle)
    fill_in 'Reading', with: 123_456
    click_on 'Create Odometer reading', match: :first

    assert_text 'Odometer reading was successfully created.'
    assert_text "Odometer for #{@vehicle.display_name}: 123,456 miles"
  end
end
