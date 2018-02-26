class  Frontend::DatumsController < FrontendController
  inherit_resources
  skip_before_action :verify_authenticity_token

  load_and_authorize_resource :except => :create

  assign_params :todo_id, :files

  def create
    # binding.pry
    create! do |success, failure|
      success.html {  }
      failure.html {redirect_to frontend_comment_path(resource.todo_id),
        notice: "Can not update files."}
    end
  end
end
