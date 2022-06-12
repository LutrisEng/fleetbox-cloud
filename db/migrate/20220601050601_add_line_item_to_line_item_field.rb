# frozen_string_literal: true

class AddLineItemToLineItemField < ActiveRecord::Migration[7.0]
  def change
    add_reference :line_item_fields, :line_item, null: false, foreign_key: true
  end
end
