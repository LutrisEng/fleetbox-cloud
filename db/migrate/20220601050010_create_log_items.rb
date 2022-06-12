# frozen_string_literal: true

class CreateLogItems < ActiveRecord::Migration[7.0]
  def change
    create_table :log_items do |t|
      t.text :display_name
      t.boolean :include_time
      t.datetime :performed_at

      t.timestamps

      t.index :performed_at
    end
  end
end
