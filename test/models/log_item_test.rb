# frozen_string_literal: true

require 'test_helper'

class LogItemTest < ActiveSupport::TestCase
  test 'added_tire_sets on factory returns the factory tires' do
    log_item = log_items(:pipers_car_factory)
    expected_tire_set = tire_sets(:pipers_factory_tires)
    tire_sets = log_item.added_tire_sets
    assert_equal(1, tire_sets.count)
    tire_set = tire_sets[0]
    assert_equal(expected_tire_set, tire_set)
  end

  test 'removed_tire_sets on factory returns nothing' do
    log_item = log_items(:pipers_car_factory)
    tire_sets = log_item.removed_tire_sets
    assert_equal(0, tire_sets.count)
  end

  test 'added_tire_sets on breakin returns nothing' do
    log_item = log_items(:pipers_car_breakin)
    tire_sets = log_item.added_tire_sets
    assert_equal(0, tire_sets.count)
  end

  test 'removed_tire_sets on breakin returns nothing' do
    log_item = log_items(:pipers_car_breakin)
    tire_sets = log_item.removed_tire_sets
    assert_equal(0, tire_sets.count)
  end

  test 'added_tire_sets on tire change returns new tires' do
    log_item = log_items(:pipers_car_summer_tires)
    expected_tire_set = tire_sets(:pipers_summer_tires)
    tire_sets = log_item.added_tire_sets
    assert_equal(1, tire_sets.count)
    tire_set = tire_sets[0]
    assert tire_set == expected_tire_set
  end

  test 'removed_tire_sets on tire change returns old tires' do
    log_item = log_items(:pipers_car_summer_tires)
    expected_tire_set = tire_sets(:pipers_factory_tires)
    tire_sets = log_item.removed_tire_sets
    assert_equal(1, tire_sets.count)
    tire_set = tire_sets[0]
    assert tire_set == expected_tire_set
  end

  test 'chonological sorting works' do
    expected_log_items = [
      log_items(:pipers_car_factory),
      log_items(:pipers_car_breakin),
      log_items(:pipers_car_summer_tires)
    ]
    assert_equal(expected_log_items, LogItem.chrono)
  end

  test 'inverse chonological sorting works' do
    expected_log_items = [
      log_items(:pipers_car_summer_tires),
      log_items(:pipers_car_breakin),
      log_items(:pipers_car_factory)
    ]
    assert_equal(expected_log_items, LogItem.inverse_chrono)
  end
end
