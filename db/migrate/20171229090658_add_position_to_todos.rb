class AddPositionToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :position, :integer, default: 0
  end
end
