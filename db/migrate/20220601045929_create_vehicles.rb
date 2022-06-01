class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.decimal :breakin
      t.text :display_name
      t.text :make
      t.decimal :miles_per_year
      t.text :model
      t.text :vin
      t.text :model_year

      t.timestamps
    end
  end
end
