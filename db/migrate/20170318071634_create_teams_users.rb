class CreateTeamsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :teams_users do |t|
      t.belongs_to :team
      t.belongs_to :user
    end
  end
end
