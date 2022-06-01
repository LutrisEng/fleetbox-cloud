class CreateShops < ActiveRecord::Migration[7.0]
  def change
    create_table :shops do |t|
      t.text :email
      t.text :location
      t.text :name
      t.text :notes
      t.text :phone_number
      t.text :url

      t.timestamps
    end
  end
end
