# frozen_string_literal: true

json.odometer_readings @vehicle.odometer_readings do |odometer_reading|
  json.partial! 'odometer_readings/odometer_reading', odometer_reading:
end
json.vehicle do
  json.partial! 'vehicles/vehicle', vehicle: @vehicle
end
