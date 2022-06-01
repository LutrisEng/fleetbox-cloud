class AddVehicleToOdometerReading < ActiveRecord::Migration[7.0]
  def change
    add_reference :odometer_readings, :vehicle, null: false, foreign_key: true
  end
end
