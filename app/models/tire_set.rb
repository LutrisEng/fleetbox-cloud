class TireSet < ApplicationRecord
  has_many :line_item_fields, foreign_key: :tire_set_value_id

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
    if mounted_line_item.nil?
      return mounted_line_item
    end
    dismounted_line_items = line_items
                              .with_type('dismountedTires')
                              .where_field_value('tireSet', self)
                              .where_vehicle(mounted_line_item.vehicle)
                              .where_after(mounted_line_item.performed_at)
    if dismounted_line_items.empty?
      mounted_line_item.vehicle
    end
  end

  def odometer
    counter = 0
    mounted_on = nil
    mounted_at = nil
    log_items.chrono.each do |log_item|
      if log_item.removed_tire_sets.where(id: id).exists?
        if log_item.odometer_reading
          counter += log_item.odometer_reading.reading - (mounted_at || 0)
        elsif log_item.vehicle
          counter += log_item.vehicle.odometer_readings.closest_to(log_item.performed_at).reading - (mounted_at || 0)
        end
        mounted_on = nil
        mounted_at = nil
      end
      if log_item.added_tire_sets.where(id: id).exists?
        if mounted_on && mounted_at
          last_before_this = mounted_on.odometer_readings.first_before(mounted_at)
          soonest_after_this = mounted_on.odometer_readings.soonest_after(mounted_at)
          if last_before_this
            counter += last_before_this.reading - mounted_at
          elsif soonest_after_this
            counter += soonest_after_this.reading - mounted_at
          else
            counter += mounted_on.odometer - mounted_at
          end
        elsif !mounted_on.nil?
          counter += mounted_on.odometer
        end

        mounted_at = log_item.odometer_reading&.reading || log_item.vehicle.odometer_readings.closest_to(log_item.performed_at)&.reading || 0
        mounted_on = log_item.vehicle
      end
    end
    if mounted_at && mounted_on
      counter += mounted_on.odometer - mounted_at
    end
    counter + (base_miles || 0)
  end

  def specs
    def maybe(x)
      if x.blank? || x == 0
        "?"
      else
        if x.is_a? Numeric
          "%d" % x
        else
          x.to_s
        end
      end
    end
    "#{maybe(vehicle_type)}#{maybe(width)}/#{maybe(aspect_ratio)}#{maybe(construction)}#{maybe(diameter)} #{maybe(load_index)}#{maybe(speed_rating)}"
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
end
