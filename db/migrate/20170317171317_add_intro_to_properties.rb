class AddIntroToProperties < ActiveRecord::Migration[5.0]
  def change
    add_column :properties, :intro, :string
  end
end
