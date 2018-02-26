class AddStepIdToTodo < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :step_id, :integer
  end
end
