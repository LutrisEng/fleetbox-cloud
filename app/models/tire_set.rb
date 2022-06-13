# frozen_string_literal: true

class TireSet < ApplicationRecord
  has_many :line_item_fields, foreign_key: :tire_set_value_id
  belongs_to :owner, class_name: 'User', optional: false

  scope :with_owner, ->(owner) { where(owner:) }

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
                        .with_type('mountedTires')
                        .where_field_value('tireSet', self)
                        .inverse_chrono
                        .first
    return mounted_line_item if mounted_line_item.nil?

    dismounted_line_items = line_items
                            .with_type('dismountedTires')
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
    maybe = lambda { |x|
      if x.blank? || (x.is_a?(Numeric) && x.zero?)
        '?'
      elsif x.is_a? Numeric
        '%d' % x
      else
        x.to_s
      end
    }
    "#{maybe.call(vehicle_type)}#{maybe.call(width)}/#{maybe.call(aspect_ratio)}#{maybe.call(construction)}#{maybe.call(diameter)} #{maybe.call(load_index)}#{maybe.call(speed_rating)}"
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

  def generate_display_name
    dm_make = make || 'Unknown Make'
    dm_model = model || 'Unknown Model'
    "#{dm_make} #{dm_model} (#{specs})"
  end

  def display_name
    user_display_name || generate_display_name
  end
end
