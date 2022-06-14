# frozen_string_literal: true

json.extract! vehicle, :id, :breakin, :user_display_name, :display_name, :make, :miles_per_year, :model, :vin, :model_year, :created_at,
              :updated_at
json.current_tires_url tire_set_url(vehicle.current_tires, format: :json) if vehicle.current_tires
json.log_items vehicle.log_items do |log_item|
  json.url log_item_url(log_item, format: :json)
end
json.url vehicle_url(vehicle, format: :json)
