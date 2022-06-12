# frozen_string_literal: true

class AddShopToLogItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :log_items, :shop, null: true, foreign_key: true
  end
end
