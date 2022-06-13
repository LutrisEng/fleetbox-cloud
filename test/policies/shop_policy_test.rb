# frozen_string_literal: true

require 'test_helper'

class ShopPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    factory = shops(:bmw_factory)
    dealer = shops(:bmw_dealer)
    discount_tire = shops(:discount_tire)
    user = users(:piper)
    shops = ShopPolicy::Scope.new(user, Shop).resolve
    assert(shops.include?(factory))
    assert(shops.include?(dealer))
    assert(shops.include?(discount_tire))
    user.admin = false
    shops = ShopPolicy::Scope.new(user, Shop).resolve
    assert_equal(3, shops.count)
    assert(shops.include?(factory))
    assert(shops.include?(dealer))
    assert(shops.include?(discount_tire))
  end

  def test_scope_mock
    factory = shops(:bmw_factory)
    dealer = shops(:bmw_dealer)
    discount_tire = shops(:discount_tire)
    user = users(:mock)
    shops = ShopPolicy::Scope.new(user, Shop).resolve
    assert(shops.include?(factory))
    assert(shops.include?(dealer))
    assert(shops.include?(discount_tire))
    user.admin = false
    shops = ShopPolicy::Scope.new(user, Shop).resolve
    assert_equal(0, shops.count)
  end

  def test_scope_mock_non_admin
    user = users(:mock_non_admin)
    shops = ShopPolicy::Scope.new(user, Shop).resolve
    assert_equal(0, shops.count)
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
