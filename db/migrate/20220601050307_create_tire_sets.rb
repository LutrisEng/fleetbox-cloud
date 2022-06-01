class CreateTireSets < ActiveRecord::Migration[7.0]
  def change
    create_table :tire_sets do |t|
      t.decimal :aspect_ratio
      t.decimal :base_miles
      t.decimal :breakin
      t.text :construction
      t.decimal :diameter
      t.boolean :hidden
      t.decimal :load_index
      t.text :make
      t.text :model
      t.text :speed_rating
      t.text :tin
      t.text :user_display_name
      t.text :vehicle_type
      t.decimal :width

      t.timestamps
    end
  end
end
