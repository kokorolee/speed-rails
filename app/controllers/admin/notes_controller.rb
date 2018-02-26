class Admin::NotesController < AdminController
  inherit_resources
  assign_params :message, :owner_id, :table
  respond_to :html, :js, :json

  def create
    super do |format|
      format.html {redirect_to customer_path(resource.customer.id)}
    end
  end

end
