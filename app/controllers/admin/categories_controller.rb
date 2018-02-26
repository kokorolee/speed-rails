class Admin::CategoriesController < AdminController
  inherit_resources
  assign_params :name, :status

  layout 'blank', only: ['new', 'show']
  respond_to :html, :js

end
