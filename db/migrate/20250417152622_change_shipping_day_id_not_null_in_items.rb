class ChangeShippingDayIdNotNullInItems < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :shipping_day_id, false
  end
end
