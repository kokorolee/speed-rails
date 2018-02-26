class AddCreatedByUpdatedByToGroupProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :group_properties, :updated_by, :integer
    add_column :group_properties, :created_by, :integer
  end
end
