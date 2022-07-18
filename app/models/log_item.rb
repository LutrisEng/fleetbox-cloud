# frozen_string_literal: true

class LogItem < ApplicationRecord
  belongs_to :vehicle
  belongs_to :shop, optional: true
  belongs_to :odometer_reading, optional: true, autosave: true
  has_many :line_items, dependent: :destroy

  before_save :copy_odometer_reading_time
  before_create :copy_odometer_reading_time

  owner_from_parent :vehicle, Vehicle

  scope :chrono, -> { order(performed_at: :asc) }
  scope :inverse_chrono, -> { order(performed_at: :desc) }
  scope :with_line_item_type, ->(type) { joins(:line_items).where(line_item: { type_id: type }).distinct(:id) }

  def copy_odometer_reading_time
    return unless odometer_reading

    odometer_reading.performed_at = performed_at
    odometer_reading.include_time = include_time
  end

  def added_tire_sets
    TireSet.joins(line_item_fields: :line_item).merge(LineItem.where(type_id: 'mountedTires', log_item: self))
  end

  def removed_tire_sets
    TireSet.joins(line_item_fields: :line_item).merge(LineItem.where(type_id: 'dismountedTires', log_item: self))
  end

  def odometer_reading_reading
    odometer_reading&.reading
  end

  def odometer_reading_reading=(reading)
    if odometer_reading
      if reading.present?
        odometer_reading.reading = reading
        odometer_reading.include_time = include_time
      else
        odometer_reading.destroy!
      end
    elsif reading.present?
      self.odometer_reading = OdometerReading.new(vehicle:, reading:, performed_at:, include_time:)
    end
  end

  def shop_uuid
    shop&.uuid
  end

  def shop_uuid=(new_uuid)
    self.shop = Shop.find_by(uuid: new_uuid)
  end

  def gid_class_name
    'log_item'
  end
end
