class CreateStepWorkflows < ActiveRecord::Migration[5.1]
  def change
    create_table :step_workflows do |t|
      t.string :parent_id
      t.string :name
      t.timestamps
    end
  end
end
