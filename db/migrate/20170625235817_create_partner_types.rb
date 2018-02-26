class CreatePartnerTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :partner_types do |t|
      t.string :name, null: false, default: ""
      t.string :desc, null: false, default: ""
      t.float :reduction, null: false, default: 0
      t.string :condition, null: false, default: ""
      t.integer :status, null: false, default: 0
      t.timestamps null: false
    end
  end
end
