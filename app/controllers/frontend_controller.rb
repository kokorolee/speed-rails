class FrontendController < ApplicationController
  before_action :authenticate_any!
  
  # check_authorization
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to frontend_root_path, :alert => exception.message
  end
end
