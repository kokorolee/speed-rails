class CreateStepCheckLists < ActiveRecord::Migration[5.1]
  def change
    create_table :step_check_lists do |t|
      t.string :name
      t.integer :check_list_id
      t.integer :no

      t.timestamps
    end
  end
end
