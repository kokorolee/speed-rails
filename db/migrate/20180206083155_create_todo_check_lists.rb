class CreateTodoCheckLists < ActiveRecord::Migration[5.1]
  def change
    create_table :todo_check_lists do |t|
      t.string :todo_id
      t.integer :step_check_list_id
      t.integer :status

      t.timestamps
    end
  end
end
