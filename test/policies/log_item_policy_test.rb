# frozen_string_literal: true

require 'test_helper'

class LogItemPolicyTest < ActiveSupport::TestCase
  def test_scope_piper
    user = users(:piper)
    user.admin = false
    log_items = LogItemPolicy::Scope.new(user, LogItem).resolve
    assert(log_items.include?(log_items(:pipers_car_factory)))
  end

  def test_scope_mock
    user = users(:mock)
    user.admin = false
    log_items = LogItemPolicy::Scope.new(user, LogItem).resolve
    assert_not(log_items.include?(log_items(:pipers_car_factory)))
  end

  def test_show; end

  def test_create; end

  def test_update; end

  def test_destroy; end
end
