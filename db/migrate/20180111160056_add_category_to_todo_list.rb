class AddCategoryToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :category, :integer
  end
end
