class CreateData < ActiveRecord::Migration[5.1]
  def change
    create_table :data do |t|
      t.integer :todo_id
      t.string :files

      t.timestamps
    end
  end
end
