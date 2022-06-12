# frozen_string_literal: true

class AddVehicleToLogItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :log_items, :vehicle, null: false, foreign_key: true
    add_index :log_items, %i[vehicle_id performed_at]
  end
end
