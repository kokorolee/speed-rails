class CreateGroupProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :group_properties do |t|
      t.string :name, null: false, default: ""
      t.integer :status,null: false, default: 1
      t.string :group_type, null: false, default: ""
      t.timestamps
    end
  end
end
