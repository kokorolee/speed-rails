class Team < ApplicationRecord
  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller && controller.current_user }

  validates :name, :presence => true
  has_and_belongs_to_many :users
  has_many :todo_lists

end
