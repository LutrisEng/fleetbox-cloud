# frozen_string_literal: true

class TireSet < ApplicationRecord
  has_many :line_item_fields, foreign_key: :tire_set_value_id, dependent: :nullify, inverse_of: :tire_set_value
  belongs_to :owner, class_name: 'User', optional: false
  before_save :convert_blank_to_nil

  owner_from_record

  def convert_blank_to_nil
    self.user_display_name = nil if user_display_name.blank?
    self.make = nil if make.blank?
    self.model = nil if model.blank?
    self.tin = nil if tin.blank?
  end

  def line_items
    LineItem
      .joins(:line_item_fields)
      .merge(line_item_fields)
      .distinct(:id)
  end

  def log_items
    LogItem
      .joins(:line_items)
      .merge(line_items)
      .distinct(:id)
  end

  def current_vehicle
    mounted_line_item = line_items
                        .where_type('mountedTires')
                        .where_field_value('tireSet', self)
                        .inverse_chrono
                        .first
    return nil if mounted_line_item.nil?

    dismounted_line_items = line_items
                            .where_type('dismountedTires')
                            .where_field_value('tireSet', self)
                            .where_vehicle(mounted_line_item.vehicle)
                            .where_after(mounted_line_item.performed_at)
    mounted_line_item.vehicle if dismounted_line_items.empty?
  end

  def odometer
    counter = 0
    mounted_on = nil
    mounted_at = nil
    log_items.chrono.each do |log_item|
      if log_item.removed_tire_sets.exists?(id:)
        if log_item.odometer_reading
          counter += log_item.odometer_reading.reading - (mounted_at || 0)
        elsif log_item.vehicle
          counter += log_item.vehicle.odometer_readings.closest_to(log_item.performed_at).reading - (mounted_at || 0)
        end
        mounted_on = nil
        mounted_at = nil
      end
      next unless log_item.added_tire_sets.exists?(id:)

      if mounted_on && mounted_at
        last_before_this = mounted_on.odometer_readings.first_before(mounted_at)
        soonest_after_this = mounted_on.odometer_readings.soonest_after(mounted_at)
        counter += if last_before_this
                     last_before_this.reading - mounted_at
                   elsif soonest_after_this
                     soonest_after_this.reading - mounted_at
                   else
                     mounted_on.odometer - mounted_at
                   end
      elsif !mounted_on.nil?
        counter += mounted_on.odometer
      end

      mounted_at = log_item.odometer_reading&.reading || log_item.vehicle.odometer_readings.closest_to(log_item.performed_at)&.reading || 0
      mounted_on = log_item.vehicle
    end
    counter += mounted_on.odometer - mounted_at if mounted_at && mounted_on
    counter + (base_miles || 0)
  end

  def specs
    "#{spec_maybe(vehicle_type)}#{spec_maybe(width)}/#{spec_maybe(aspect_ratio)}#{spec_maybe(construction)}#{spec_maybe(diameter)} #{spec_maybe(load_index)}#{spec_maybe(speed_rating)}"
  end

  def origin
    log_items.chrono.first&.performed_at
  end

  def category
    if hidden
      :hidden
    elsif current_vehicle
      :mounted
    else
      :unmounted
    end
  end

  def display_make
    make || I18n.t('tire_set.unknown_make')
  end

  def display_model
    model || I18n.t('tire_set.unknown_model')
  end

  def generate_display_name
    "#{display_make} #{display_model} (#{specs})"
  end

  def display_name
    user_display_name || generate_display_name
  end

  private

  def spec_maybe(spec)
    if spec.blank? || (spec.is_a?(Numeric) && spec.zero?)
      '?'
    elsif spec.is_a? Numeric
      spec.round.to_s
    else
      spec.to_s
    end
  end
end
