# frozen_string_literal: true

require 'test_helper'

class VehicleTest < ActiveSupport::TestCase
  test 'display name works when nothing is set' do
    vehicle = Vehicle.new
    assert_equal '[Unknown year] [Unknown make] [Unknown model]', vehicle.display_name
  end

  test 'display name works when one part is unset' do
    vehicle = Vehicle.new(model_year: '2022', make: 'BMW')
    assert_equal '2022 BMW [Unknown model]', vehicle.display_name
    vehicle = Vehicle.new(model_year: '2022', model: 'M340i')
    assert_equal '2022 [Unknown make] M340i', vehicle.display_name
    vehicle = Vehicle.new(make: 'BMW', model: 'M340i')
    assert_equal '[Unknown year] BMW M340i', vehicle.display_name
  end

  test 'display name works when overridden by user_display_name' do
    vehicle = Vehicle.new(model_year: '2022', make: 'BMW', model: 'M340i')
    assert_equal '2022 BMW M340i', vehicle.display_name
    vehicle.user_display_name = 'My car'
    assert_equal 'My car', vehicle.display_name
    vehicle.user_display_name = nil
    assert_equal '2022 BMW M340i', vehicle.display_name
  end
end
