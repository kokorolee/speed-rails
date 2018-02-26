class AddCreatedByUpdatedByToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :updated_by, :integer
    add_column :users, :created_by, :integer
  end
end
