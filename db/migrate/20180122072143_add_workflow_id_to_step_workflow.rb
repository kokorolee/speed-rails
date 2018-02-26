class AddWorkflowIdToStepWorkflow < ActiveRecord::Migration[5.1]
  def change
    add_column :step_workflows, :workflow_id, :integer
  end
end
