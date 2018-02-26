class Product < ApplicationRecord
  belongs_to :category
  has_and_belongs_to_many :user
  has_and_belongs_to_many :customers

  enumerize :status, in: {active: 1, pending: 2}
  enumerize :product_type, in: {services: 1, products: 2}
end

