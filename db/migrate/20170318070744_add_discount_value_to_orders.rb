class AddDiscountValueToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :discount_value, :float
  end
end
