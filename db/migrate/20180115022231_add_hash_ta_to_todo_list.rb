class AddHashTaToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :hash_tag, :string
  end
end
