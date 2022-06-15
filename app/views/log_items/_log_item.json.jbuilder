# frozen_string_literal: true

json.extract! log_item, :id, :display_name, :include_time, :performed_at, :created_at, :updated_at
json.url vehicle_log_item_url(vehicle, log_item, format: :json)
