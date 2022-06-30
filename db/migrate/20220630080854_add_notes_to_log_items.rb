# frozen_string_literal: true

class AddNotesToLogItems < ActiveRecord::Migration[7.0]
  def change
    add_column :log_items, :notes, :text
  end
end
