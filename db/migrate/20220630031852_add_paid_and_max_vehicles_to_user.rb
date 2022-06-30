# frozen_string_literal: true

class AddPaidAndMaxVehiclesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :paid, :boolean, default: false, null: false
    add_column :users, :max_vehicles, :bigint, default: 1, null: false
  end
end
