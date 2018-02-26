class AddLocationToTodo < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :location, :string
  end
end
