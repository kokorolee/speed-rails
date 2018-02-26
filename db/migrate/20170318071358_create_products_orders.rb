class CreateProductsOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :products_orders do |t|
      t.belongs_to :product
      t.belongs_to :order
    end
  end
end
