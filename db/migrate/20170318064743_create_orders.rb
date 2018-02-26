class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :order_no
      t.string :order_date
      t.integer :state

      t.timestamps
    end
  end
end
