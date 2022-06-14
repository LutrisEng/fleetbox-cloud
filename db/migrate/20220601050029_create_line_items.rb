# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.text :notes
      t.bigint :sort_order
      t.text :type_id

      t.timestamps

      t.index :type_id
    end
  end
end
