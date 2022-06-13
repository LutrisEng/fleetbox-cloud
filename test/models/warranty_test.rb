# frozen_string_literal: true

require 'test_helper'

class WarrantyTest < ActiveSupport::TestCase
  test 'inherits owner from tire set / vehicle' do
    warranty = warranties(:pipers_car_warranty)
    assert_equal(warranty.owner, users(:piper))
    warranty.vehicle = nil
    warranty.tire_set = tire_sets(:pipers_summer_tires)
    assert_equal(warranty.owner, users(:piper))
  end
end
