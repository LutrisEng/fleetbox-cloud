# frozen_string_literal: true

require 'test_helper'

class TireSetPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    factory = tire_sets(:pipers_factory_tires)
    summer = tire_sets(:pipers_summer_tires)
    user = users(:piper)
    tire_sets = TireSetPolicy::Scope.new(user, TireSet).resolve
    assert(tire_sets.include?(factory))
    assert(tire_sets.include?(summer))
    user.admin = false
    tire_sets = TireSetPolicy::Scope.new(user, TireSet).resolve
    assert_equal(2, tire_sets.count)
    assert(tire_sets.include?(factory))
    assert(tire_sets.include?(summer))
  end

  def test_scope_mock
    user = users(:mock)
    tire_sets = TireSetPolicy::Scope.new(user, TireSet).resolve
    assert(tire_sets.include?(tire_sets(:pipers_summer_tires)))
    assert(tire_sets.include?(tire_sets(:pipers_factory_tires)))
    user.admin = false
    tire_sets = TireSetPolicy::Scope.new(user, TireSet).resolve
    assert_equal(0, tire_sets.count)
  end

  def test_scope_mock_non_admin
    user = users(:mock_non_admin)
    tire_sets = TireSetPolicy::Scope.new(user, TireSet).resolve
    assert_equal(0, tire_sets.count)
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
