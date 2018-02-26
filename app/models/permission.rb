class Permission < ApplicationRecord
  validates :action, :presence => true
  # validates :subject_id, :presence => true
  has_and_belongs_to_many :roles
end
