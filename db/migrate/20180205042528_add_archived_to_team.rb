class AddArchivedToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :archived, :boolean
  end
end
