class CreateOdometerReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :odometer_readings do |t|
      t.datetime :at
      t.boolean :include_time
      t.decimal :reading

      t.timestamps
    end
  end
end
