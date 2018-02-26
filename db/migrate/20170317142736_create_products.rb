class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, default: ""
      t.integer :product_type, null: false, default: 1
      t.integer :created_by
      t.integer :updated_by
      t.integer :user_id, null: true, default: 0
      t.float :price, null: true, default: 0.0
      t.float :discount_price, null: false, default: 0.0
      t.integer :status, null: false, default: 1
      t.integer :category_id, null: false, default: 0

      t.timestamps
    end
  end
end
