class AddArchivedToTodo < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :archived, :boolean
  end
end
