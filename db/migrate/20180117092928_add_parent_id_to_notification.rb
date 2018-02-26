class AddParentIdToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :parent_id, :integer
  end
end
