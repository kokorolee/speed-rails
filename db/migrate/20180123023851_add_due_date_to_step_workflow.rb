class AddDueDateToStepWorkflow < ActiveRecord::Migration[5.1]
  def change
    add_column :step_workflows, :estimate, :float
  end
end
