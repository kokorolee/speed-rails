class AddSlugToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :slug, :string
  end
end
