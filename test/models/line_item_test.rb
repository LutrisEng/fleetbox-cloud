require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  test "chono order is correct" do
    ordered_items = LineItem.chrono
    assert_operator ordered_items.index(line_items(:pipers_car_factory_tires)), :<, ordered_items.index(line_items(:pipers_car_summer_tires_dismount))
  end

  test "inverse chrono order is correct" do
    ordered_items = LineItem.inverse_chrono
    assert_operator ordered_items.index(line_items(:pipers_car_factory_tires)), :>, ordered_items.index(line_items(:pipers_car_summer_tires_dismount))
  end

  test "can find all line items with type" do
    expected_line_items = [
      line_items(:pipers_car_factory_tires),
      line_items(:pipers_car_summer_tires_mount)
    ]
    assert_equal(expected_line_items, LineItem.with_type('mountedTires').chrono)
  end

  test "can find all line items with type on vehicle" do
    expected_line_items = [
      line_items(:pipers_car_factory_tires),
      line_items(:pipers_car_summer_tires_mount)
    ]
    assert_equal(expected_line_items, vehicles(:pipers_car).line_items.with_type("mountedTires").chrono)
  end

  test "can get string field values" do
    assert_equal("BMW", line_items(:pipers_car_breakin_oil).get_field_value("brand"))
  end

  test "can get tire set field values" do
    assert_equal(tire_sets(:pipers_factory_tires), line_items(:pipers_car_factory_tires).get_field_value("tireSet"))
  end

  test "can roundtrip string field values" do
    line_item = LineItem::new(log_item: log_items(:pipers_car_summer_tires), type_id: "engineOilChange")
    assert_nil(line_item.get_field_value("brand"))
    line_item.set_field_value!("brand", "BMW")
    assert_equal("BMW", line_item.get_field_value("brand"))
  end

  test "can roundtrip tire set field values" do
    line_item = LineItem::new(log_item: log_items(:pipers_car_breakin), type_id: "mountedTires")
    assert_nil(line_item.get_field_value("tireSet"))
    line_item.set_field_value!("tireSet", tire_sets(:pipers_summer_tires))
    assert_equal(tire_sets(:pipers_summer_tires), line_item.get_field_value("tireSet"))
  end

  test "can roundtrip boolean field values" do
    line_item = LineItem::new(log_item: log_items(:pipers_car_breakin), type_id: "basicPreDrive")
    assert_nil(line_item.get_field_value("lowBeams"))
    line_item.set_field_value!("lowBeams", true)
    assert_equal(true, line_item.get_field_value("lowBeams"))
  end

  test "can create field if doesn't exist" do
    line_item = line_items(:pipers_car_factory_oil)
    assert_nil(line_item.get_field_value("brand"))
    assert_nil(line_item.get_field("brand"))
    field = line_item.get_field!("brand")
    assert_equal(field, line_item.get_field("brand"))
    assert_nil(line_item.get_field_value("brand"))
    field.string_value = "BMW"
    field.save!
    assert_equal(field, line_item.get_field("brand"))
    assert_equal("BMW", line_item.get_field_value("brand"))
  end

  test "can destroy field" do
    line_item = line_items(:pipers_car_breakin_oil)
    assert_equal("BMW", line_item.get_field_value("brand"))
    assert_not_nil(line_item.get_field("brand"))
    line_item.destroy_field!("brand")
    assert_nil(line_item.get_field_value("brand"))
    assert_nil(line_item.get_field("brand"))
  end

  test "gets vehicle from log item properly" do
    vehicle = vehicles(:pipers_car)
    vehicle.line_items.each do |line_item|
      assert_equal(vehicle, line_item.log_item.vehicle)
      assert_equal(vehicle, line_item.vehicle)
    end
  end

  test "gets odometer from log item properly" do
    log_item = log_items(:pipers_car_breakin)
    log_item.line_items.each do |line_item|
      assert_equal(log_item.odometer_reading.reading, line_item.odometer_reading.reading)
    end
  end

  test "invalid type id fails validation" do
    line_item = line_items(:pipers_car_breakin_oil)
    assert line_item.valid?
    line_item.type_id = "THIS DOESN'T EXIST"
    refute line_item.valid?
    assert_not_nil line_item.errors[:type_id]
  end
end
