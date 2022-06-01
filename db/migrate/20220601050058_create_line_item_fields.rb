class CreateLineItemFields < ActiveRecord::Migration[7.0]
  def change
    create_table :line_item_fields do |t|
      t.decimal :decimal_value
      t.text :string_value
      t.text :type_id

      t.timestamps
    end
  end
end
