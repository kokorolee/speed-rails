class CreateProperties < ActiveRecord::Migration[5.0]
  def change
    create_table :properties do |t|
      t.string :name, null: false, default: ""
      t.integer :group_property_id, null: false, default: ""
      t.integer :property_type, null: false, default: 1
      t.boolean :property_required, null: false, default: false
      t.integer :status, null: false, default: 1
      t.boolean :can_modify, null: false, default: true

      t.timestamps
    end
  end
end
