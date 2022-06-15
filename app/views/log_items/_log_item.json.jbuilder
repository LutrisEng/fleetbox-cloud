# frozen_string_literal: true

json.extract! log_item, :uuid, :display_name, :include_time, :performed_at, :created_at, :updated_at
json.url vehicle_log_item_url(vehicle, log_item, format: :json)
if log_item.odometer_reading
  json.odometer_reading_url vehicle_odometer_readings_url(vehicle, log_item.odometer_reading, format: :json)
end
json.vehicle_url vehicle_url(vehicle)
