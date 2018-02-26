class CreatePermissionsRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions_roles, id: false do |t|
      t.belongs_to :permission
      t.belongs_to :role
    end
  end
end
