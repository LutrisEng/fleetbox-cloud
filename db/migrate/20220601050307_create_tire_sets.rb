# frozen_string_literal: true

class CreateTireSets < ActiveRecord::Migration[7.0]
  def change
    create_table :tire_sets do |t|
      t.bigint :aspect_ratio
      t.bigint :base_miles
      t.bigint :breakin
      t.text :construction
      t.bigint :diameter
      t.boolean :hidden
      t.bigint :load_index
      t.text :make
      t.text :model
      t.text :speed_rating
      t.text :tin
      t.text :user_display_name
      t.text :vehicle_type
      t.bigint :width

      t.timestamps
    end
  end
end
