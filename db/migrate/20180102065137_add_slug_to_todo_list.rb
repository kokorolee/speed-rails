class AddSlugToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :slug, :string
  end
end
