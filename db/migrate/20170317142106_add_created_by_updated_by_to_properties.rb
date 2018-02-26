class AddCreatedByUpdatedByToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :updated_by, :integer
    add_column :properties, :created_by, :integer
  end
end
