class AddPrivateToTodo < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :private, :integer
  end
end
