class Frontend::TodoListsController < FrontendController
  before_action :check_use, cannot: ['new']
  inherit_resources
  after_action :notify_create, only: ['create']
  load_and_authorize_resource :except => :create

  # load_and_authorize_resource
  assign_params :parent_id, :name, :desc ,:team_id, :category, :hash_tag
  # khong cho user vao team k thuoc
  def check_use
    if !(params[:id]).nil?
      if !((Team.find_by_id(TodoList.find_by_id(params[:id]).team_id).users).include?(current_user))
        redirect_to frontend_root_path,
        notice: "You cannot see Todo List"
      end
    end
  end


  def create
    create! do |success, failure|
      success.html {
        # adđ question
        if resource.category=="question"
          date = params[:deadline]
          (1..params[:stt].to_i).each do |i|
            name ="question"+i.to_s
            Team.find_by_id(resource.team_id).users.each do |user|
              @todo = Todo.new
              @todo.name = params[name.to_sym]
              @todo.status = "undone"
              @todo.category = "question"
              @todo.todo_list_id = resource.id
              @todo.user_id = user.id
              @todo.due_date = params[:deadline]
              @todo.estimate = 0
              if @todo.save
                Notification.create(event: "created", user_id: current_user.id, category: "todo", parent_id: @todo.id, url: "todos/" + @todo.id.to_s)
              end
            end
          end
          redirect_to frontend_team_todo_list_path(team_id: resource.team_id,id: resource.id),
          notice: "Todo list (question) has been created."
        elsif params[:todo_list][:parent_id].present?
          StepWorkflow.where(workflow_id: params[:todo_list][:parent_id].to_i).order("id ASC").each do |step|
            str = "name_step_"+step.id.to_s
            deadline = "deadline-"+step.id.to_s
            @todo = Todo.new
            @todo.name = step.name
            @todo.estimate = step.estimate
            @todo.user_id = params[str.to_sym]
            @todo.category = 1
            @todo.due_date = params[deadline.to_sym]
            @todo.status = "undone"
            @todo.step_id = step.id
            @todo.todo_list_id = resource.id
            if @todo.save
              Notification.create(event: "created",user_id: current_user.id, category: "todo", parent_id: @todo.id, url: "todos/" + @todo.id.to_s)
            end
            # binding.pry
          end
          redirect_to frontend_team_todo_list_path(team_id: resource.team_id,id: resource.id),
          notice: "Todo list (workflow) has been created."
        else
          redirect_to frontend_team_todo_list_path(team_id: resource.team_id,id: resource.id),
          notice: "Todo list has been created."
        end
      }
      failure.html { redirect_to frontend_root_path(),
        notice: "Can not create Todo list."}
    end
  end

  def update
    @todolist = TodoList.find(params[:id])
    @name = params[:name];

    if (@name=="delete")
      if @todolist.update_attributes(:archived => true)
        Notification.create(event: "delete", user_id: current_user.id, category: "todo list",team_id:resource.team.id, parent_id: resource.id , url: "teams/"+resource.team_id.to_s+"/todo_lists/"+resource.id.to_s)
        flash[:notice] = "Todo list deleted."
      end
    elsif (@name=="re-open-todo-list")
      @todolist.update_attributes(:archived => false)
      flash[:notice] = "Todo list re-open."
      Notification.create(event: "re-open", user_id: current_user.id, category: "todo list",team_id:resource.team.id, parent_id: resource.id , url: "teams/"+resource.team_id.to_s+"/todo_lists/"+resource.id.to_s)
    else
      update! do |success, failure|
        success.html {

          if resource.category=="question"
            resource.todos.where(category: "question").each do |todo|
              todo.delete
            end
            (1..params[:stt].to_i).each do |i|
              name ="question"+i.to_s
              Team.find_by_id(resource.team_id).users.each do |user|
                @todo = Todo.new
                @todo.name = params[name.to_sym]
                @todo.status = "undone"
                # caterory =1 no checnk metting
                @todo.category = "question"
                @todo.todo_list_id = resource.id
                @todo.user_id = user.id
                @todo.due_date = params[:deadline]
                @todo.save
              end
            end
          elsif params[:todo_list][:parent_id].present?
            StepWorkflow.where(workflow_id: params[:todo_list][:parent_id].to_i).each do |step|
              str = "name_step_"+step.id.to_s
              deadline = "deadline-"+step.id.to_s
              @todo = Todo.where(todo_list_id: resource.id, step_id: step.id).first
              if @todo.present?
                @todo.name = step.name
                @todo.estimate = step.estimate
                @todo.user_id = params[str.to_sym]
                @todo.category = 1
                @todo.due_date = params[deadline.to_sym]
                @todo.status = "undone"
                @todo.step_id = step.id
                @todo.todo_list_id = resource.id
                @todo.save
              else
                @todo = Todo.new
                @todo.name = step.name
                @todo.estimate = step.estimate
                @todo.user_id = params[str.to_sym]
                @todo.category = 1
                @todo.due_date = params[deadline.to_sym]
                @todo.status = "undone"
                @todo.step_id = step.id
                @todo.todo_list_id = resource.id
                if @todo.save
                  Notification.create(event: "created",user_id: current_user.id, category: "todo", parent_id: @todo.id, url: "todos/" + @todo.id.to_s)
                end
              end
            end
          end
          Notification.create(event: "updated", user_id: current_user.id, category: "todo list",team_id:resource.team.id, parent_id: resource.id , url: "teams/"+resource.team_id.to_s+"/todo_lists/"+resource.id.to_s)
          redirect_to frontend_team_todo_list_path(team_id: resource.team_id, id: resource.id),
          notice: "Todo list has been updated." }
        failure.html {redirect_to frontend_team_path(resource.team_id),
          notice: "Can not update Todo list."}
      end
    end
  end


  def show
    if params[:q].present?
      # @todo_lists_s = TodoList.where("slug ilike ?", "%#{params[:q]}%")
      @todos_s = Todo.where("slug ilike ?", "%#{params[:q]}%")
    end
  end

  def index
    if params[:q].present?
      @todo_lists_s = @todo_lists.where("slug ilike ?", "%#{params[:q]}%")
      @todos_s = Todo.where("slug ilike ?", "%#{params[:q]}%")
    end
    if params[:workflow].present?
      @steps = Array.new
      StepWorkflow.where(workflow_id: params[:workflow]).order("parent_id ASC").each do |step|
        @steps.push("id"=>step.id,"name"=>step.name)
      end

      @users = Array.new
      Team.find_by_id(Workflow.find_by_id(params[:workflow]).parent_id).users.each do |user|
        @users.push("id"=>user.id, "name"=>user.fullname)
      end
      list = Array.new
      list.push("step" => @steps, "users" => @users)
      respond_to do |format|
        format.any(:html, :js, :json) { render json: list.to_json }
      end
    end
  end

  private
    def notify_create
      Notification.create(event: "created", user_id: current_user.id, category: "todo list",team_id:resource.team.id, parent_id: resource.id, url: "teams/"+resource.team_id.to_s+"/todo_lists/"+resource.id.to_s)
    end
  protected
     def collection
       @todo_lists = TodoList.where(:archived => [false,nil])
     end
end
