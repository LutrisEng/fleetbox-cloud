# frozen_string_literal: true

class AddUuids < ActiveRecord::Migration[7.0]
  def add_uuid_column_on(table)
    add_column table, :uuid, :uuid, default: 'gen_random_uuid()', null: false
    add_index table, :uuid, unique: true
  end

  def change
    enable_extension 'pgcrypto'
    add_uuid_column_on :line_item_fields
    add_uuid_column_on :line_items
    add_uuid_column_on :log_items
    add_uuid_column_on :odometer_readings
    add_uuid_column_on :shops
    add_uuid_column_on :tire_sets
    add_uuid_column_on :users
    add_uuid_column_on :vehicles
    add_uuid_column_on :warranties
  end
end
