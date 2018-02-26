class AddDescToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :desc, :string
  end
end
