class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.integer :label
      t.string :name
      t.string :intro
      t.string :warning
      t.integer :status, null: false, default: 1
      t.boolean :can_modify, null: false, default: true
      t.boolean :can_delete, null: false, default: true

      t.timestamps
    end
  end
end
