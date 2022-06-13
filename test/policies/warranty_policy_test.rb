# frozen_string_literal: true

require 'test_helper'

class WarrantyPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    user = users(:piper)
    user.admin = false
    warranties = WarrantyPolicy::Scope.new(user, Warranty).resolve
    print warranties.to_sql
    assert(warranties.include?(warranties(:pipers_car_warranty)))
  end

  def test_scope_mock
    user = users(:mock)
    user.admin = false
    warranties = WarrantyPolicy::Scope.new(user, Warranty).resolve
    assert_not(warranties.include?(warranties(:pipers_car_warranty)))
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
