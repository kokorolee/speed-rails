class Admin::GroupPropertiesController < AdminController
  inherit_resources
  layout 'blank', only: ['new', 'show']
  respond_to :html, :js

  assign_params :name, :group_type

end
