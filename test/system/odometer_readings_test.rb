# frozen_string_literal: true

require 'application_system_test_case'

class OdometerReadingsTest < ApplicationSystemTestCase
  setup do
    @vehicle = vehicles(:pipers_car)
  end

  test 'should get index' do
    visit vehicle_odometer_readings_url(@vehicle)
    assert_selector 'h1', text: 'Odometer for'
  end

  test 'should add odometer reading' do
    @vehicle = Vehicle.create(owner: users(:mock))

    visit vehicle_odometer_readings_url(@vehicle)
    fill_in 'Reading', with: 123_456
    click_on 'Create Odometer reading', match: :first

    assert_text 'Odometer reading was successfully created.'
    assert_text "Odometer for #{@vehicle.display_name}: 123,456 miles"
  end
end
