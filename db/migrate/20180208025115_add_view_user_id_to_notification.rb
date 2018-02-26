class AddViewUserIdToNotification < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :view_user_id, :string
  end
end
