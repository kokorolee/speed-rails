class Comment < ApplicationRecord
  mount_uploader :files, ImageUploader
  # tracked owner: ->(controller, model) { controller && controller.current_user }
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :todo_id, :presence => true
  belongs_to :todo
  belongs_to :user





end
