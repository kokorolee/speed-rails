class Datum < ApplicationRecord
  mount_uploader :files, ImageUploader
end
