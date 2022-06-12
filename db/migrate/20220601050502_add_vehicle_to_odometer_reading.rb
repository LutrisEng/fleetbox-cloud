# frozen_string_literal: true

class AddVehicleToOdometerReading < ActiveRecord::Migration[7.0]
  def change
    add_reference :odometer_readings, :vehicle, null: false, foreign_key: true
    add_index :odometer_readings, %i[vehicle_id performed_at]
  end
end
