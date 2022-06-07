class Vehicle < ApplicationRecord
  has_many :log_items
  has_many :odometer_readings

  def line_items
    LineItem.joins(:log_item).merge(log_items).distinct(:id)
  end

  def odometer
    odometer_readings.inverse_chrono.first&.reading || 0
  end

  def record_odometer_reading!(reading)
    OdometerReading::create(vehicle: self, performed_at: Time.now, reading: reading)
  end

  def current_tires
    line_items
      .with_type("mountedTires")
      .with_field_value("tireSet")
      .inverse_chrono
      .first
      &.get_field_value("tireSet")
  end
end
