class CreateCheckLists < ActiveRecord::Migration[5.1]
  def change
    create_table :check_lists do |t|
      t.string :name
      t.text :desc
      t.integer :todo_list_id

      t.timestamps
    end
  end
end
