class GroupProperty < ApplicationRecord
  has_many :properties
  GROUP_TYPE = ['customers', 'users', 'products']
  enumerize :group_type, in: GROUP_TYPE
end
