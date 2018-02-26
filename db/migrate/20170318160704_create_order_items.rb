class CreateOrderItems < ActiveRecord::Migration[5.0]
  def change
    create_table :order_items do |t|
      t.integer :order_id, null: false, default: ""
      t.integer :product_id, null: false, default: ""
      t.integer :qty, null: false, default: 1
      t.integer :user_id
      t.float :amount, null: false, default: 0.0

      t.timestamps
    end
  end
end
