json.extract! tire_set, :id, :aspect_ratio, :base_miles, :breakin, :construction, :diameter, :hidden, :load_index, :make, :model, :speed_rating, :tin, :user_display_name, :vehicle_type, :width, :odometer, :specs, :created_at, :updated_at
if tire_set.current_vehicle
  json.current_vehicle_url vehicle_url(tire_set.current_vehicle, format: :json)
end
json.url tire_set_url(tire_set, format: :json)
