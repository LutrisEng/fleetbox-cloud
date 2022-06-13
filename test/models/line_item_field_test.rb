# frozen_string_literal: true

require 'test_helper'

class LineItemFieldTest < ActiveSupport::TestCase
  def create_line_item(type)
    LineItem.new(log_item: log_items(:pipers_car_breakin), type_id: type)
  end

  test 'can create valid string field' do
    line_item = create_line_item('engineOilChange')
    field = LineItemField.new(line_item:, type_id: 'brand', string_value: 'BMW')
    assert field.valid?
    assert_equal('string', field.data_type)
  end

  test 'can create valid string field with no value' do
    line_item = create_line_item('engineOilChange')
    field = LineItemField.new(line_item:, type_id: 'brand')
    assert field.valid?
    assert_equal('string', field.data_type)
  end

  test 'can create valid boolean field' do
    line_item = create_line_item('basicPreDrive')
    field = LineItemField.new(line_item:, type_id: 'lowBeams', boolean_value: true)
    assert field.valid?
    assert_equal('boolean', field.data_type)
  end

  test 'can create valid boolean field with no value' do
    line_item = create_line_item('basicPreDrive')
    field = LineItemField.new(line_item:, type_id: 'lowBeams')
    assert field.valid?
    assert_equal('boolean', field.data_type)
  end

  test 'can create valid enum field' do
    line_item = create_line_item('tireRotation')
    field = LineItemField.new(line_item:, type_id: 'pattern', string_value: 'forwardCross')
    assert field.valid?
    assert_equal('enum', field.data_type)
  end

  test 'can create valid enum field with no value' do
    line_item = create_line_item('tireRotation')
    field = LineItemField.new(line_item:, type_id: 'pattern')
    assert field.valid?
    assert_equal('enum', field.data_type)
  end

  test "invalid enum value doesn't pass validation" do
    line_item = create_line_item('tireRotation')
    field = LineItemField.new(line_item:, type_id: 'pattern', string_value: 'invalidValue')
    assert_not field.valid?
    assert_not_nil field.errors[:string_value]
    assert_equal('enum', field.data_type)
  end

  test 'can create valid decimal field' do
    line_item = create_line_item('washSealant')
    field = LineItemField.new(line_item:, type_id: 'warranty', decimal_value: 4)
    assert field.valid?
    assert_equal('decimal', field.data_type)
  end

  test 'can create valid decimal field with no value' do
    line_item = create_line_item('washSealant')
    field = LineItemField.new(line_item:, type_id: 'warranty')
    assert field.valid?
    assert_equal('decimal', field.data_type)
  end

  test 'can create valid tire set field' do
    line_item = create_line_item('mountedTires')
    field = LineItemField.new(line_item:, type_id: 'tireSet', tire_set_value: tire_sets(:pipers_summer_tires))
    assert field.valid?
    assert_equal('tireSet', field.data_type)
  end

  test 'can create valid tire set field with no value' do
    line_item = create_line_item('mountedTires')
    field = LineItemField.new(line_item:, type_id: 'tireSet')
    assert field.valid?
    assert_equal('tireSet', field.data_type)
  end

  test "string field with boolean value doesn't pass validation" do
    line_item = create_line_item('engineOilChange')
    field = LineItemField.new(line_item:, type_id: 'brand', boolean_value: true)
    assert_not field.valid?
    assert_not_nil field.errors[:boolean_value]
    assert_equal('string', field.data_type)
  end

  test 'inherits owner from line item / log item / vehicle' do
    assert_equal(line_item_fields(:pipers_car_factory_tires).owner, users(:piper))
  end
end
