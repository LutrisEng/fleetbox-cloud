# frozen_string_literal: true

class CreateWarranties < ActiveRecord::Migration[7.0]
  def change
    create_table :warranties do |t|
      t.bigint :miles
      t.bigint :months
      t.text :title

      t.timestamps
    end
  end
end
