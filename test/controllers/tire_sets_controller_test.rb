# frozen_string_literal: true

require 'test_helper'

class TireSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tire_set = tire_sets(:pipers_summer_tires)
  end

  test 'should get index' do
    get tire_sets_url
    assert_response :success
  end

  test 'should get new' do
    get new_tire_set_url
    assert_response :success
  end

  test 'should create tire_set' do
    assert_difference('TireSet.count') do
      post tire_sets_url,
           params: { tire_set: { aspect_ratio: @tire_set.aspect_ratio, base_miles: @tire_set.base_miles,
                                 breakin: @tire_set.breakin, construction: @tire_set.construction,
                                 diameter: @tire_set.diameter, hidden: @tire_set.hidden,
                                 load_index: @tire_set.load_index, make: @tire_set.make, model: @tire_set.model,
                                 speed_rating: @tire_set.speed_rating, tin: @tire_set.tin,
                                 user_display_name: @tire_set.user_display_name, vehicle_type: @tire_set.vehicle_type,
                                 width: @tire_set.width } }
    end

    assert_redirected_to tire_set_url(TireSet.last)
  end

  test 'should show tire_set' do
    get tire_set_url(@tire_set)
    assert_response :success
  end

  test 'should get edit' do
    get edit_tire_set_url(@tire_set)
    assert_response :success
  end

  test 'should update tire_set' do
    patch tire_set_url(@tire_set),
          params: { tire_set: { aspect_ratio: @tire_set.aspect_ratio, base_miles: @tire_set.base_miles,
                                breakin: @tire_set.breakin, construction: @tire_set.construction, diameter: @tire_set.diameter, hidden: @tire_set.hidden, load_index: @tire_set.load_index, make: @tire_set.make, model: @tire_set.model, speed_rating: @tire_set.speed_rating, tin: @tire_set.tin, user_display_name: @tire_set.user_display_name, vehicle_type: @tire_set.vehicle_type, width: @tire_set.width } }
    assert_redirected_to tire_set_url(@tire_set)
  end

  test 'should destroy tire_set' do
    @tire_set = TireSet.create(owner: users(:piper))

    assert_difference('TireSet.count', -1) do
      delete tire_set_url(@tire_set)
    end

    assert_redirected_to tire_sets_url
  end
end
