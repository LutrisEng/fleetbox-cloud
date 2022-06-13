# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.boolean :admin, null: false, default: false
      t.string :name

      t.timestamps
    end
    add_index :users, :email
  end
end
