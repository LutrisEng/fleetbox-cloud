# frozen_string_literal: true

require 'test_helper'

class LogItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle = vehicles(:pipers_car)
    @log_item = log_items(:pipers_car_breakin)
  end

  test 'should get index' do
    get vehicle_log_items_url(@vehicle)
    assert_response :success
  end

  test 'should get new' do
    get new_vehicle_log_item_url(@vehicle)
    assert_response :success
  end

  test 'should create log_item' do
    assert_difference('LogItem.count') do
      post vehicle_log_items_url(@vehicle),
           params: { log_item: { display_name: @log_item.display_name, include_time: @log_item.include_time,
                                 performed_at: @log_item.performed_at } }
    end

    assert_redirected_to vehicle_log_item_url(@vehicle, LogItem.last)
  end

  test 'should show log_item' do
    get vehicle_log_item_url(@vehicle, @log_item)
    assert_response :success
  end

  test 'should get edit' do
    get edit_vehicle_log_item_url(@vehicle, @log_item)
    assert_response :success
  end

  test 'should update log_item' do
    patch vehicle_log_item_url(@vehicle, @log_item),
          params: { log_item: { display_name: @log_item.display_name, include_time: @log_item.include_time,
                                performed_at: @log_item.performed_at } }
    assert_redirected_to vehicle_log_item_url(@vehicle, @log_item)
  end

  test 'should destroy log_item' do
    @log_item = LogItem.create(vehicle: vehicles(:pipers_car))

    assert_difference('LogItem.count', -1) do
      delete vehicle_log_item_url(@vehicle, @log_item)
    end

    assert_redirected_to vehicle_log_items_url(@vehicle)
  end
end
