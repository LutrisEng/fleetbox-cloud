class CreateLineItemFields < ActiveRecord::Migration[7.0]
  def change
    create_table :line_item_fields do |t|
      t.decimal :decimal_value
      t.text :string_value
      t.boolean :boolean_value
      t.text :type_id

      t.timestamps

      t.index :type_id
    end
  end
end
