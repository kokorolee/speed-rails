module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_authencation
  end

  protected
  def check_authencation
    flash.clear
    if current_user || current_partner
      # if you have rails_admin. You can redirect anywhere really
      redirect_to(root_path) && return
    else current_shopper
      # The authenticated root path can be defined in your routes.rb in: devise_scope :user do...
      redirect_to(authenticated_user_path) && return
    end
  end
end