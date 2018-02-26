class User < ApplicationRecord
  mount_uploader :avatar, ImageUploader
  # validates :email, :format => /.*@.*/
  # validates :fullname, :presence => true
  # validates :password, length: { in: 6..30 }
  # validates :role_id, :presence => true



  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :permissions, through: :roles
  has_many :products
  has_many :property_matches, :foreign_key => 'object_id'
  belongs_to :role
  has_and_belongs_to_many :teams
  has_and_belongs_to_many :todos
  has_many :todos
  has_and_belongs_to_many :commnets
  accepts_nested_attributes_for :property_matches
  has_and_belongs_to_many :notifications

  # default 0, quan ly team: 1, member 2, quan ly het :3
  enumerize :super_role, in: {no: 0, team: 1, member: 2, team_member: 3}

  def has_role?(role_sym)
    roles.any? { |r| r.name.downcase.underscore.to_sym == role_sym }
  end


end
