class AddVehicleToWarranty < ActiveRecord::Migration[7.0]
  def change
    add_reference :warranties, :vehicle, null: true, foreign_key: true
  end
end
