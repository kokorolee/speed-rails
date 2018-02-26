class PropertyMatch < ApplicationRecord
  belongs_to :customer, :foreign_key => 'object_id'
  belongs_to :user, :foreign_key => 'object_id'
  belongs_to :property

  mount_uploader :photo, PhotoUploader

end
