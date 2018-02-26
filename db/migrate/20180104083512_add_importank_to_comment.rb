class AddImportankToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :importank, :integer
  end
end
