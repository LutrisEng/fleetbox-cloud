# frozen_string_literal: true

class AddOwnerToTireSet < ActiveRecord::Migration[7.0]
  def change
    add_reference :tire_sets, :owner, null: false, foreign_key: { to_table: :users }
  end
end
