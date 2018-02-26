class CreateTableCustomersPartners < ActiveRecord::Migration[5.0]
  def change
    create_table :customers_partners,  id: false do |t|
      t.belongs_to :customer
      t.belongs_to :partner
    end
  end
end
