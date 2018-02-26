class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.string :code
      t.string :fullname
      t.integer :title
      t.string :phone_number
      t.string :email
      t.integer :source_id
      t.boolean :private
      t.integer :assign_user_id
      t.integer :state_id
      t.integer :status
      t.string :note
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end
end
