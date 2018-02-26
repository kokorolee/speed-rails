class AddParentIdToTodo < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :parent_id, :integer
  end
end
