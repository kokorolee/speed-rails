class Note < ApplicationRecord
  belongs_to :customer, foreign_key: 'owner_id'
end
