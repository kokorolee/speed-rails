class  Frontend::TeamsController < FrontendController
  before_action :check_use_team, cannot: ['show']
  inherit_resources

  load_and_authorize_resource :except => :create


  # khong cho user vao team k thuoc
  def check_use_team
    if !(params[:id]).nil?
      if resource.archived == true
        redirect_to frontend_root_path,
        notice: "URL not found";
      end

      users = resource.users
      if !(users.include?(current_user))
        redirect_to frontend_root_path,
        notice: "Team not Assigned"
      end
    end
  end


  assign_params :name, :desc, :user_ids => []
  def show
    @todo_lists = resource.todo_lists.where(:archived => [nil,false]).limit(10)
    if params[:q].present?
      @todo_lists = @todo_lists.where("slug ilike ?", "%#{params[:q]}%")
      @todos = Todo.where("slug ilike ?", "%#{params[:q]}%")
    end
    @team = resource
  end

  def create
    create! do |success, failure|
      success.html {
        redirect_to frontend_team_path(resource),
        notice: "Team has been created."}
      failure.html { redirect_to frontend_root_path,
        notice: "Can not create team."}
    end
  end


  def team_archived_todo
    @todo_lists = resource.todo_lists.where(:archived => [nil,false])
    if params[:q].present?
      @todo_lists = @todo_lists.where("slug ilike ?", "%#{params[:q]}%")
      @todos = Todo.where("slug ilike ?", "%#{params[:q]}%")
    end

    @team = Team.find_by_id(params[:id])
    @todo_lists = @team.todo_lists.where(:archived => true)
  end

  def update

    @name = params[:name];

    if (@name=="delete")
      if resource.update_attributes(:archived => true)
        flash[:notice] = "Team deleted."
      end
    # elsif (@name=="re-open-todo-list")
    #   @todolist.update_attributes(:archived => false)
    #   flash[:notice] = "Todo list re-open."
    #   Notification.create(event: "re-open", user_id: current_user.id, category: "todo list",team_id:resource.team.id, parent_id: resource.id , url: "teams/"+resource.team_id.to_s+"/todo_lists/"+resource.id.to_s)
    else
      update! do |success, failure|
        success.html {
            redirect_to frontend_team_path(resource),
          notice: "Team has been updated." }
        failure.html {  redirect_to frontend_root_path,
          notice: "Can not update Team."}
      end
    end
  end

  def index
    member_ids = []
    teams = current_user.teams
    teams.each do |team|
      user_ids = team.users.pluck(:id)
      member_ids = member_ids + user_ids
    end
    member_ids = member_ids.uniq
    @members =  User.includes(:teams).where(id: member_ids)
  end
end
