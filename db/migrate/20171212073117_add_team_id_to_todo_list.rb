class AddTeamIdToTodoList < ActiveRecord::Migration[5.1]
  def change
    add_column :todo_lists, :team_id, :integer
  end
end
