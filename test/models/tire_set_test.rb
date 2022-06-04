require "test_helper"

class TireSetTest < ActiveSupport::TestCase
  test "line_items returns the correct line items" do
    tire_set = tire_sets(:pipers_factory_tires)
    expected_line_items = [
      line_items(:pipers_car_factory_tires),
      line_items(:pipers_car_summer_tires_dismount)
    ]
    assert_equal(expected_line_items, tire_set.line_items.chrono)
  end

  test "log_items returns the correct log items" do
    tire_set = tire_sets(:pipers_factory_tires)
    expected_log_items = [
      log_items(:pipers_car_factory),
      log_items(:pipers_car_summer_tires)
    ]
    assert_equal(expected_log_items, tire_set.log_items.chrono)
  end

  test "vehicle doesn't fetch a vehicle when dismounted" do
    assert_nil(tire_sets(:pipers_factory_tires).current_vehicle)
  end

  test "vehicle fetches the current vehicle when mounted" do
    assert_equal(vehicles(:pipers_car), tire_sets(:pipers_summer_tires).current_vehicle)
  end

  test "odometer calculates properly" do
    assert_equal(7557, tire_sets(:pipers_factory_tires).odometer)
    assert_equal(0, tire_sets(:pipers_summer_tires).odometer)
    vehicles(:pipers_car).record_odometer_reading!(10000)
    assert_equal(7557, tire_sets(:pipers_factory_tires).odometer)
    assert_equal(2443, tire_sets(:pipers_summer_tires).odometer)
  end

  test "odometer stress test" do
    COUNT = 1000
    ActiveRecord::Base.transaction do
      vehicle = Vehicle::create!
      clock = Time.at(0)
      odometer = 0
      last_tire_set = nil
      (1..COUNT).each do |x|
        clock += 1.month
        odometer += rand(5000..10000)
        tire_set = TireSet::create!
        log_item = LogItem::create!(vehicle: vehicle, performed_at: clock)
        log_item.odometer_reading = OdometerReading::create!(vehicle: vehicle, performed_at: clock, reading: odometer)
        mounted_line_item = LineItem::create!(log_item: log_item, type_id: 'mountedTires')
        mounted_line_item.set_field_value!('tireSet', tire_set)
        if last_tire_set
          dismounted_line_item = LineItem::create!(log_item: log_item, type_id: 'dismountedTires')
          dismounted_line_item.set_field_value!('tireSet', last_tire_set)
        end
        last_tire_set = tire_set
      end
      assert_equal(odometer, vehicle.odometer)
    end
    tire_sets = TireSet.all
    assert_operator tire_sets.count, :>=, COUNT
    tire_sets.each do |tire_set|
      assert_not_nil(tire_set.odometer)
    end
  end

  test "specs generates correct format" do
    ts = tire_sets(:pipers_summer_tires)
    ts.vehicle_type = "P"
    ts.width = 225
    ts.aspect_ratio = 40
    ts.construction = "ZR"
    ts.diameter = 19
    ts.load_index = 93
    ts.speed_rating = "Y"
    assert_equal("P225/40ZR19 93Y", ts.specs)
  end

  test "origin returns timestamp of first log item" do
    assert_equal(Time.iso8601("2022-01-06T01:03:03-06:00"), tire_sets(:pipers_factory_tires).origin)
  end

  test "category functions as expected" do
    summer_tires = tire_sets(:pipers_summer_tires)
    factory_tires = tire_sets(:pipers_factory_tires)
    assert_equal(:mounted, summer_tires.category)
    assert_equal(:unmounted, factory_tires.category)
    summer_tires.hidden = true
    factory_tires.hidden = true
    assert_equal(:hidden, summer_tires.category)
    assert_equal(:hidden, factory_tires.category)
  end
end
