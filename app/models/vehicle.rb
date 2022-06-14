# frozen_string_literal: true

class Vehicle < ApplicationRecord
  has_many :log_items, dependent: :destroy
  has_many :odometer_readings, dependent: :destroy
  belongs_to :owner, class_name: 'User', optional: false
  before_save :convert_blank_to_nil
  validates :model_year, numericality: true, allow_nil: true

  owner_from_record

  def convert_blank_to_nil
    self.user_display_name = nil if user_display_name.blank?
    self.make = nil if make.blank?
    self.model = nil if model.blank?
    self.model_year = nil if model_year.blank?
    self.vin = nil if vin.blank?
  end

  def line_items
    LineItem.joins(:log_item).merge(log_items).distinct(:id)
  end

  def odometer
    odometer_readings.inverse_chrono.first&.reading || 0
  end

  def record_odometer_reading!(reading)
    OdometerReading.create(vehicle: self, performed_at: Time.zone.now, reading:)
  end

  def current_tires
    line_items
      .where_type('mountedTires')
      .with_field_value('tireSet')
      .inverse_chrono
      .first
      &.get_field_value('tireSet')
  end

  def display_model_year
    model_year || 'Unknown Year'
  end

  def display_make
    make || 'Unknown Make'
  end

  def display_model
    model || 'Unknown Model'
  end

  def generate_display_name
    "#{display_model_year} #{display_make} #{display_model}"
  end

  def display_name
    user_display_name || generate_display_name
  end
end
