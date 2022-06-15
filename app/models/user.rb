# frozen_string_literal: true

class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  has_many :vehicles, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  has_many :shops, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  has_many :tire_sets, foreign_key: :owner_id, dependent: :destroy, inverse_of: :owner
  validate :ensure_timezone_exists

  def owner
    self
  end

  def log_items
    LogItem.where_owner(self)
  end

  def line_items
    LineItem.where_owner(self)
  end

  def line_item_fields
    LineItemField.where_owner(self)
  end

  def odometer_readings
    OdometerReading.where_owner(self)
  end

  def warranties
    Warranty.where_owner(self)
  end

  def tz
    ActiveSupport::TimeZone.new(timezone)
  end

  def ensure_timezone_exists
    errors.add(:timezone, "Invalid timezone \"#{timezone}\"") unless tz
  end

  def now
    Time.now.in_time_zone(tz)
  end
end
