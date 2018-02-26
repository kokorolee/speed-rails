class AddGroupIdToCustomers < ActiveRecord::Migration[5.0]
  def change
    add_column :customers, :group_id, :integer
  end
end
