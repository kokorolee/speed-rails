class AddPhotoToPropertyMatches < ActiveRecord::Migration[5.0]
  def change
    add_column :property_matches, :photo, :json
  end
end
