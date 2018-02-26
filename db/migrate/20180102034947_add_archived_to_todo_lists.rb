class AddArchivedToTodoLists < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :archived, :boolean
  end
end
