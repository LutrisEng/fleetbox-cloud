class AddTireSetToWarranty < ActiveRecord::Migration[7.0]
  def change
    add_reference :warranties, :tire_set, null: true, foreign_key: true
  end
end
