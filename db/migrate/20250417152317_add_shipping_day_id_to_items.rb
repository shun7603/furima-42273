class AddShippingDayIdToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :shipping_day_id, :integer
  end
end
