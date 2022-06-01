class AddShopToLogItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :log_items, :shop, null: false, foreign_key: true
  end
end
