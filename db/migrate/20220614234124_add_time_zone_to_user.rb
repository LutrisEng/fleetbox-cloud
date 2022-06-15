class AddTimeZoneToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :timezone, :text, null: false, default: 'Central Time (US & Canada)'
  end
end
