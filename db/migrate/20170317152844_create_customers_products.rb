class CreateCustomersProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :customers_products, id: false do |t|
      t.belongs_to :customer
      t.belongs_to :product
    end
  end
end
