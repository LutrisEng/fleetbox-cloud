require "test_helper"

class LogItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @log_item = log_items(:pipers_car_breakin)
  end

  test "should get index" do
    get log_items_url
    assert_response :success
  end

  test "should get new" do
    get new_log_item_url
    assert_response :success
  end

  test "should create log_item" do
    assert_difference("LogItem.count") do
      post log_items_url, params: { log_item: { display_name: @log_item.display_name, include_time: @log_item.include_time, performed_at: @log_item.performed_at, vehicle_id: @log_item.vehicle_id } }
    end

    assert_redirected_to log_item_url(LogItem.last)
  end

  test "should show log_item" do
    get log_item_url(@log_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_log_item_url(@log_item)
    assert_response :success
  end

  test "should update log_item" do
    patch log_item_url(@log_item), params: { log_item: { display_name: @log_item.display_name, include_time: @log_item.include_time, performed_at: @log_item.performed_at } }
    assert_redirected_to log_item_url(@log_item)
  end

  test "should destroy log_item" do
    @log_item = LogItem.create(vehicle: vehicles(:pipers_car))

    assert_difference("LogItem.count", -1) do
      delete log_item_url(@log_item)
    end

    assert_redirected_to log_items_url
  end
end
