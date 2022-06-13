# frozen_string_literal: true

class AddOwnerToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_reference :vehicles, :owner, null: false, foreign_key: { to_table: :users }
  end
end
