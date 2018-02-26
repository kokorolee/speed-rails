class AddArchivedToWorkflow < ActiveRecord::Migration[5.1]
  def change
    add_column :workflows, :archived, :boolean
  end
end
