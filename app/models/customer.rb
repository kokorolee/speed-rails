class Customer < ApplicationRecord

  has_and_belongs_to_many :products

  belongs_to :state, :class_name  => 'Group', :foreign_key => 'state_id'
  belongs_to :source, :class_name => 'Group', :foreign_key => 'source_id'
  belongs_to :group, :class_name  => 'Group', :foreign_key => 'group_id'

  has_many :property_matches, :foreign_key => 'object_id'
  has_many :orders
  has_many :notes,  foreign_key: 'owner_id', inverse_of: :customer
  has_and_belongs_to_many :partners
  accepts_nested_attributes_for :property_matches

end
