class Frontend::ActivitiesController < FrontendController
  before_action :check_use_team, cannot: ['index']
  # khong cho user vao team k thuoc
  def check_use_team
    if !params[:team_id].nil?
      users = Team.find_by_id(params[:team_id]).users
      if !(users.include?(current_user))
        redirect_to frontend_root_path,
        notice: "Team not Assigned"
      end
    end
  end

  def index
    @notifications = Array.new
    if params[:name]=="more"
      # Notification.where(:team_id => params[:team_id]).order("category, parent_id desc").limit(15).offset(params[:offset]).each do |notification|
      Notification.where(:team_id => params[:team_id]).order("created_at DESC, parent_id DESC, category DESC").limit(15).offset(params[:offset]).each do |notification|
          datetime = notification.created_at.strftime("%k:%M:%S - %d/%m/%Y")
          fullname = User.find_by_id(notification.user_id).fullname
          event = notification.event
          category = notification.category
          if notification.category.to_s=="comment"
              name = Todo.find_by_id(notification.parent_id).name
          else
              if notification.category.to_s=="todo"
                name = Todo.find_by_id(notification.parent_id).name
              elsif notification.category.to_s=="todo list"
                name = TodoList.find_by_id(notification.parent_id).name
              end
          end
          @notifications.push("datetime" => datetime, "fullname" => fullname, "event" => event, "category" => category, "name" => name)
      end
      respond_to do |format|
        format.any(:html, :js, :json) { render json: @notifications.to_json }
      end
    end
  end
end
