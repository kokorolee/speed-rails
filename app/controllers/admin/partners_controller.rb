class Admin::PartnersController < AdminController
  inherit_resources
  layout 'blank', only: ['new', 'show']
  respond_to :html, :js
  # before_action :properties, only: ['index','new', 'edit', 'show']

  assign_params :id, :password, :email, :fullname,:phone, :partner_type_id


  def update
    if params[:partner][:password].blank?
      params[:partner].delete("password")
      params[:partner].delete("password_confirmation")
    end
    update! do |success, failure|
      success.html { redirect_to admin_partners_path(),
        notice: "partner has been updated." }
      failure.html {redirect_to admin_partners_path(),
        notice: "Can not update user."}
    end
  end

  def create
    create! do |success, failure|
      success.html { redirect_to admin_partners_path(),
        notice: "partner has been updated." }
      failure.html {redirect_to admin_partners_path(),
        notice: "Can not update user."}
    end
  end

  protected
    def redirect_home
      redirect_to admin_users_path
    end

    # def properties

    #   @group_properties = GroupProperty.includes(:properties).where("group_type = ?", 'users')
    #   @keys = []
    #   @group_properties.each do |g|
    #     @keys += g.properties.pluck(:name)
    #   end
    # end

    def collection
      @partners = Partner.all
      @partners = @partners.where(partner_type_id: params[:type].to_i) if params[:type].present?
    end
end
