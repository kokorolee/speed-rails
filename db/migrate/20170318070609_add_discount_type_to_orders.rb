class AddDiscountTypeToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :total_amount, :float
    add_column :orders, :discount_type, :integer
    add_column :orders, :real_amount, :float
  end
end
