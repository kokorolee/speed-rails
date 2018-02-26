class AddSuperRoleToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :super_role, :integer
  end
end
