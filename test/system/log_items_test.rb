# frozen_string_literal: true

require 'application_system_test_case'

class LogItemsTest < ApplicationSystemTestCase
  setup do
    @log_item = log_items(:pipers_car_factory)
    @vehicle = vehicles(:pipers_car)
  end

  test 'visiting the index' do
    visit vehicle_log_items_url(@vehicle)
    assert_selector 'h1', text: 'Log items'
  end

  test 'should create log item' do
    visit vehicle_log_items_url(@vehicle)
    click_on 'New log item'

    fill_in 'Display name', with: @log_item.display_name
    check 'Include time' if @log_item.include_time
    fill_in 'Performed at', with: @log_item.performed_at
    fill_in 'Vehicle', with: @log_item.vehicle_id
    click_on 'Create Log item'

    assert_text 'Log item was successfully created'
    click_on 'Back'
  end

  test 'should update Log item' do
    visit vehicle_log_item_url(@vehicle, @log_item)
    click_on 'Edit this log item', match: :first

    fill_in 'Display name', with: @log_item.display_name
    check 'Include time' if @log_item.include_time
    fill_in 'Performed at', with: @log_item.performed_at.strftime("%m%d%Y\t%I%M%P")
    click_on 'Update Log item'

    assert_text 'Log item was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Log item' do
    @log_item = LogItem.create(vehicle: vehicles(:pipers_car))

    visit vehicle_log_item_url(@vehicle, @log_item)
    click_on 'Destroy this log item', match: :first

    assert_text 'Log item was successfully destroyed'
  end
end
