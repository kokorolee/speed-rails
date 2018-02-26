class AddTeamIdToCheckList < ActiveRecord::Migration[5.1]
  def change
    add_column :check_lists, :team_id, :integer
  end
end
