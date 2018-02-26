class TodoList < ApplicationRecord
  # include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller && controller.current_user }

  validates :name, :presence => true
  validates :team_id, :presence => true
  belongs_to :team
  has_many :todos
  has_many :check_lists
  before_save :make_alias
  enumerize :category, in: {project: 1, workflow: 2, question: 3}

  protected
    def make_alias
      self.slug = self.name.downcase.to_slug.transliterate(:vietnamese).to_s
    end


end
