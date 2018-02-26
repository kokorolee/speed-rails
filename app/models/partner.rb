class Partner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    belongs_to :partner_type
    has_and_belongs_to_many :customers


  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

  before_save :ensure_access_token

  private

    def ensure_access_token
      if access_token.blank?
        self.access_token = generate_authentication_token
      end
    end


    def generate_authentication_token
      if !changes.has_key?("access_token") or (!changes[:access_token][0].present? and !changes[:access_token][1].nil?)
        loop do
          token = SecureRandom.urlsafe_base64(48)
          break token unless Partner.where(access_token: token).first
        end
      end
    end

end
