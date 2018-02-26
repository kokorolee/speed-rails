class CreatePropertyMatches < ActiveRecord::Migration[5.0]
  def change
    create_table :property_matches do |t|
      t.integer :object_id
      t.integer :property_id
      t.string :property_key
      t.string :property_value

      t.timestamps
    end
  end
end
