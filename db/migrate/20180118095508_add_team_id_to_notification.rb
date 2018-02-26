class AddTeamIdToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :team_id, :integer
  end
end
