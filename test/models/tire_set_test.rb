require "test_helper"

class TireSetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "line_items returns the factory line item and no others" do
    tire_set = tire_sets(:pipers_tires)
    line_items = tire_set.line_items
    assert line_items.count == 1
    line_item = line_items[0]
    assert line_item.type_id = 'mountedTires'
    log_item = line_item.log_item
    assert log_item.display_name == 'Vehicle manufactured'
  end
end
