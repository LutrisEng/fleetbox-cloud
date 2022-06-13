# frozen_string_literal: true

require 'test_helper'

class LineItemFieldPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    user = users(:piper)
    user.admin = false
    line_item_fields = LineItemFieldPolicy::Scope.new(user, LineItemField).resolve
    assert(line_item_fields.include?(line_item_fields(:pipers_car_factory_tires)))
  end

  def test_scope_mock
    user = users(:mock)
    user.admin = false
    line_item_fields = LineItemFieldPolicy::Scope.new(user, LineItemField).resolve
    assert_not(line_item_fields.include?(line_item_fields(:pipers_car_factory_tires)))
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
