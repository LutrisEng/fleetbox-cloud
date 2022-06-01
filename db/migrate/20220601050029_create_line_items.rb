class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.text :notes
      t.decimal :sort_order
      t.text :type_id

      t.timestamps
    end
  end
end
