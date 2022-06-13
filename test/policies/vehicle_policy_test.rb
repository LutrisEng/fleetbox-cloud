# frozen_string_literal: true

require 'test_helper'

class VehiclePolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    vehicle = vehicles(:pipers_car)
    user = users(:piper)
    vehicles = VehiclePolicy::Scope.new(user, Vehicle).resolve
    assert(vehicles.include?(vehicle))
    assert(vehicles.include?(vehicles(:mock_vehicle)))
    assert(vehicles.include?(vehicles(:mock_non_admin_vehicle)))
    user.admin = false
    vehicles = VehiclePolicy::Scope.new(user, Vehicle).resolve
    assert_equal(1, vehicles.count)
    assert_equal(vehicle, vehicles.first)
  end

  def test_scope_mock
    vehicle = vehicles(:mock_vehicle)
    user = users(:mock)
    vehicles = VehiclePolicy::Scope.new(user, Vehicle).resolve
    assert(vehicles.include?(vehicle))
    assert(vehicles.include?(vehicles(:mock_vehicle)))
    assert(vehicles.include?(vehicles(:mock_non_admin_vehicle)))
    user.admin = false
    vehicles = VehiclePolicy::Scope.new(user, Vehicle).resolve
    assert_equal(1, vehicles.count)
    assert_equal(vehicle, vehicles.first)
  end

  def test_scope_mock_non_admin
    vehicle = vehicles(:mock_non_admin_vehicle)
    user = users(:mock_non_admin)
    vehicles = VehiclePolicy::Scope.new(user, Vehicle).resolve
    assert_equal(1, vehicles.count)
    assert_equal(vehicle, vehicles.first)
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
