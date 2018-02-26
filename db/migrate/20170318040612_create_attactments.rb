class CreateAttactments < ActiveRecord::Migration[5.0]
  def change
    create_table :attactments do |t|
      t.integer :owner_id
      t.string :table

      t.timestamps
    end
  end
end
