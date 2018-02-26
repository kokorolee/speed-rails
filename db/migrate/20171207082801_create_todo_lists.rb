class CreateTodoLists < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_lists do |t|
      t.integer :parent_id
      t.string :name
      t.text :desc

      t.timestamps
    end
  end
end
