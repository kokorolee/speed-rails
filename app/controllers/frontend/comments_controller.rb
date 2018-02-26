class  Frontend::CommentsController < FrontendController
  inherit_resources
  after_action :notify_create, only: ['create']
  after_action :notify_update, only: ['update']

  skip_before_action :verify_authenticity_token

  load_and_authorize_resource :except => :create

  assign_params :user_id, :todo_id, :content, :files

  def create
    # binding.pry
    create! do |success, failure|
      success.html { }
      failure.html {redirect_to frontend_comment_path(resource.todo_id),
        notice: "Can not created comment."}
    end
  end


  def delete
    delete! do |success, failure|
      success.html { redirect_to frontend_root_path(),
        notice: "Comment has been deleted." }
      failure.html {redirect_to frontend_comment_path(resource.todo_id),
        notice: "Can not delete comment."}
    end
  end

  def update
    @comment = Comment.find(params[:id])
    # Update importank
    if (params[:name]=="importank")
      @comment.update_attributes(:importank => 1)
      @comments = Comment.where(:todo_id => params[:id_todo]).order("importank DESC")
      results = Array.new
      @comments.each do |comment|
        result = Array.new
        @u = User.find_by_id(comment.user_id)
        result.push("files" => comment.files_url,"role"=>Role.find_by_id(@u.role_id).name,"name" => @u.fullname,"avatar"=>@u.avatar_url, "user_id" => @u.id,"id" => comment.id,"importank" => comment.importank,"content" => comment.content)
        results.push(result)
      end
      respond_to do |format|
        format.any(:html, :js, :json) { render json: results.to_json }
      end
    end

    #update content
    if (params[:name]=="update-content")
      @comment.update_attributes(:content => params[:content])
      @comments = Comment.where(:todo_id => params[:id_todo]).order("created_at DESC")
      results = Array.new
      @comments.each do |comment|
        result = Array.new
        @u = User.find_by_id(comment.user_id)
        result.push("files" => comment.files_url ,"name" => @u.fullname,"role"=>Role.find_by_id(@u.role_id).name,"avatar"=>@u.avatar_url, "user_id" => @u.id,"id" => comment.id,"importank" => comment.importank,"content" => comment.content)
        results.push(result)
      end
      respond_to do |format|
        format.any(:html, :js, :json) { render json: results.to_json }
      end
    end

  end

  def view_comments
    if (params[:important].to_s=="1")
      @comments = Comment.where(:todo_id => params[:id_todo]).order("created_at DESC")
    else
      @comments = Comment.where(:todo_id => params[:id_todo]).order("importank,created_at DESC")
    end
    results = Array.new
    @comments.each do |comment|
      result = Array.new
      @u = User.find_by_id(comment.user_id)
      if comment.files_url.present?
        url=""
        if (comment.files_url.include? 'gif') or ( comment.files_url.include? 'png') or ( comment.files_url.include? 'jpeg') or ( comment.files_url.include? 'jpg')
            url = comment.files_url
        else
          url= "/assets/icons/file-208ac67f09651752ecf3162667f39cc09a83e522fe4c447c6d3beb8d7c9ff5e5.png";
        end
      end
      result.push("files" => url,"role"=>Role.find_by_id(@u.role_id).name,"avatar"=>@u.avatar_url,"name" => @u.fullname, "user_id" => @u.id,"id" => comment.id,"importank" => comment.importank,"content" => comment.content)
      results.push(result)
    end
    respond_to do |format|
      format.any(:html, :js, :json) { render json: results.to_json }
    end
  end
  private

    def notify_create
      Notification.create(event: "created", team_id: Todo.find_by_id(resource.todo_id).todo_list.team.id ,user_id: current_user.id, category: "comment", parent_id: resource.todo_id ,url: "todos/" + resource.todo_id.to_s)
    end

    def notify_update
      Notification.create(event: "updated", team_id: Todo.find_by_id(resource.todo_id).todo_list.team.id ,user_id: current_user.id, category: "comment", parent_id: resource.todo_id ,url: "todos/" + resource.todo_id.to_s)
    end
end
