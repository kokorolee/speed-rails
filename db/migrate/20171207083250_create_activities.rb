class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.integer :trackable_type
      t.integer :trackable_id
      t.integer :owner_type
      t.integer :owner_id
      t.string :key
      t.string :parameters
      t.integer :recipient_type
      t.integer :recipient_id

      t.timestamps
    end
  end
end
