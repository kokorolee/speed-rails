class Category < ApplicationRecord
  enumerize :status, in: {active: 1, pending: 2}
  has_many :products
end
