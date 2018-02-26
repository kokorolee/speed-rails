class Frontend::UsersController < FrontendController
  inherit_resources
  layout 'blank', only: ['new', 'show']
  respond_to :html, :js
  before_action :properties, only: ['index','new', 'edit', 'show']

  assign_params :avatar, :id, :password, :email, :fullname,:role_id, :super_role,  property_matches_attributes: [:id, :object_id, :property_key, :property_value, :property_id]


  def update

    if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    update! do |success, failure|
      success.html { redirect_to frontend_members_path(),
        notice: "User has been updated." }
      failure.html {redirect_to frontend_members_path(),
        notice: "Can not update user."}
    end
  end

  def create

    create! do |success, failure|
      success.html { redirect_to admin_root_path,
        notice: "User has been updated." }
      failure.html {redirect_to admin_root_path(),
        notice: "Can not update user."}
    end
  end

  protected
    def redirect_home
      redirect_to admin_users_path
    end

    def properties

      @group_properties = GroupProperty.includes(:properties).where("group_type = ?", 'users')
      @keys = []
      @group_properties.each do |g|
        @keys += g.properties.pluck(:name)
      end
    end

    def collection
      @users = User.all
    end
end
