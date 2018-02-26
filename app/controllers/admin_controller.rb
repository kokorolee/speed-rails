class AdminController < ApplicationController



  layout 'admin'
  before_action :authenticate_any!
  before_action :check_use

  # khong cho user vao team k thuoc
  def check_use
    if !(current_user.role.name=="admin")
      redirect_to frontend_root_path,
      notice: "URL not found"
    end
  end
end