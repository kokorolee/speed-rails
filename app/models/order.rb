class Order < ApplicationRecord
    enumerize :state, in: {open: 1, close: 2}
    enumerize :discount_type, in: {cash: 1, percen: 2}
    belongs_to :customer
    has_many :order_items, inverse_of: :order

    accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true
end
