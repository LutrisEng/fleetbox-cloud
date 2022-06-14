# frozen_string_literal: true

class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.bigint :breakin
      t.text :user_display_name
      t.text :make
      t.bigint :miles_per_year
      t.text :model
      t.text :vin
      t.text :model_year

      t.timestamps

      t.index :vin
    end
  end
end
