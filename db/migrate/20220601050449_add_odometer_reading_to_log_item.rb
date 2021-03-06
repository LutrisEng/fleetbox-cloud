# frozen_string_literal: true

class AddOdometerReadingToLogItem < ActiveRecord::Migration[7.0]
  def change
    add_reference :log_items, :odometer_reading, null: true, foreign_key: true
  end
end
