class AddDataCheckListToTodo < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :data_check_list, :string
  end
end
