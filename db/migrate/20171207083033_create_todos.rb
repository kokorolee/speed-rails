class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.integer :todo_list_id
      t.integer :check_list_id
      t.integer :type
      t.string :name
      t.text :desc
      t.datetime :created_by
      t.datetime :updated_by
      t.integer :status
      t.datetime :due_date
      t.integer :completed_at
      t.string :files

      t.timestamps
    end
  end
end
