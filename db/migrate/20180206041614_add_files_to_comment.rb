class AddFilesToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :files, :string
  end
end
