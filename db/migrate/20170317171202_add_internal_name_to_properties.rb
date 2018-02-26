class AddInternalNameToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :internal_name, :string
  end
end
