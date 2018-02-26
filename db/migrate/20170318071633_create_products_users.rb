class CreateProductsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :products_users do |t|
      t.belongs_to :product
      t.belongs_to :user
    end
  end
end
