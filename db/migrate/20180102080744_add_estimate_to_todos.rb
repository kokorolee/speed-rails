class AddEstimateToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :estimate, :float ,null: false, default: 0
  end
end
