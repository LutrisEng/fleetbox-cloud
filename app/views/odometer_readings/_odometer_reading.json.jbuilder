# frozen_string_literal: true

json.extract! odometer_reading, :id, :performed_at, :include_time, :reading, :created_at, :updated_at
json.vehicle_url vehicle_url(odometer_reading.vehicle, format: :json)
json.log_item_url log_item_url(odometer_reading.log_item, format: :json) if odometer_reading.log_item
# json.url odometer_reading_url(odometer_reading, format: :json)
