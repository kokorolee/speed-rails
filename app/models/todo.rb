class Todo < ApplicationRecord
  mount_uploader :files, ImageUploader
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }



  has_and_belongs_to_many :users
  belongs_to :user

  has_and_belongs_to_many :comments
  belongs_to :todo_list
  belongs_to :check_list
  enumerize :status, in: {done: 1, undone: 2, late: 3}
  enumerize :categogy, in: {todo: 1, metting: 2, quesion: 3}
  enumerize :private, in: {private: 1, public: 2}
  scope :get_todo_by_status, -> status {where(status: status)}

  validates :status, :presence => true
  validates :name, :presence => true
  validates :user_id, :presence => true
  # validates :due_date, :presence => true


  before_save :make_alias


  protected
    def make_alias
      self.slug = self.name.downcase.to_slug.transliterate(:vietnamese).to_s
    end


end
