# frozen_string_literal: true

class AddLogItemToLineItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_items, :log_item, null: false, foreign_key: true
  end
end
