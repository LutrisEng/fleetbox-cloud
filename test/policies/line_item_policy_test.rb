# frozen_string_literal: true

require 'test_helper'

class LineItemPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    user = users(:piper)
    user.admin = false
    line_items = LineItemPolicy::Scope.new(user, LineItem).resolve
    assert(line_items.include?(line_items(:pipers_car_factory_tires)))
  end

  def test_scope_mock
    user = users(:mock)
    user.admin = false
    line_items = LineItemPolicy::Scope.new(user, LineItem).resolve
    assert_not(line_items.include?(line_items(:pipers_car_factory_tires)))
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
