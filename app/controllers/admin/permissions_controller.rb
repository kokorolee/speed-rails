class Admin::PermissionsController < AdminController
  inherit_resources
  assign_params :action, :desc
  def collection
    @collection = Permission.all
  end

end
