class Admin::RolesController < AdminController
  inherit_resources

  assign_params :name, :desc, :permission_ids => []

  def collection
    @collection = Role.all
  end

end
