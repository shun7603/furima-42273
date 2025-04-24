# db/migrate/20250424022259_create_addresses.rb
class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    change_table :addresses do |t|
      t.string :postal_code
      t.integer :prefecture_id
      t.string :city
      t.string :address
      t.string :building
      t.string :phone_number
      t.references :order, foreign_key: true

    end
  end
end