class CreateWorkflows < ActiveRecord::Migration[5.1]
  def change
    create_table :workflows do |t|
      t.string :name
      t.integer :parent_id

      t.timestamps
    end
  end
end
