class AddTireSetValueToLineItemField < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_item_fields, :tire_set_value, null: false, foreign_key: { to_table: :tire_sets }
  end
end
