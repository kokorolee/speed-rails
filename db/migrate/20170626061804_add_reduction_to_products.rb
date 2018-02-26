class AddReductionToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :reduction, :float
  end
end
