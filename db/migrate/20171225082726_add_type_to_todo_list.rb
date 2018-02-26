class AddTypeToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :type, :integer
  end
end
