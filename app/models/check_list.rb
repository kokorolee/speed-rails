class CheckList < ApplicationRecord
  validates :name, :presence => true
  belongs_to :todo_list
  has_many :step_check_lists
end
