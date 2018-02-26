class CreateTodosUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :todos_users do |t|
      t.belongs_to :todo
      t.belongs_to :user
    end
  end
end
