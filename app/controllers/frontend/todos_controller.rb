class  Frontend::TodosController < FrontendController
  inherit_resources
  after_action :notify_create, only: ['create']

  load_and_authorize_resource :except => :create

  before_action :check_use, cannot: ['show']
  # khong cho user vao team k thuoc
  def check_use
    if !params[:id].nil?
      if !((Team.find_by_id(TodoList.find_by_id(Todo.find_by_id(params[:id]).todo_list_id).team_id).users).include?(current_user))
        redirect_to frontend_root_path,
        notice: "You cannot see todo!"
      end
    end
  end

  assign_params :private, :location, :parent_id,  :name, :category, :desc, :status, :due_date, :files, :todo_list_id,:step_id, :estimate, :user_id , :check_list_id, :user_ids => []
  # after_action :update_position, only: ['create']

  def check_done
    if params[:name]=="done_workflow"
      todo_id = params[:id]
      todo_list_id = params[:todo_list]
      # done all todo of todolist
      if !params[:flag].nil?
        TodoList.find_by_id(params[:todo_list]).todos.each do |todo|
          check_todo_late(todo)
        end
      else
        Todo.where(todo_list_id: todo_list_id).each do |todo|
          if todo.id.to_i < todo_id.to_i
            todo.update_attributes(:status => "done", :position => 0)
          else
            todo.update_attributes(:status => "undone", :position => 0)
          end
        end
      end
    end
  end


  def check_todo_late(todo)
    if todo.due_date.present?
      if (todo.try(:due_date) < Time.now)
        todo.update_attributes(:status => "late", :position => 0)
        Notification.create(event: "finished",team_id: todo.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: todo.id, url: "todos/" + todo.id.to_s)
        flash[:notice] = "Todo finished"
      else
        todo.update_attributes(:status => "done", :position => 0)
        Notification.create(event: "finished",team_id: todo.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: todo.id, url: "todos/" + todo.id.to_s)
        flash[:notice] = "Todo finished"
      end
    else
      # khong co deadline
      todo.update_attributes(:status => "done", :position => 0)
      Notification.create(event: "finished",team_id: todo.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: todo.id, url: "todos/" + todo.id.to_s)
      flash[:notice] = "Todo finished"
    end
  end

  def show
    @todo = resource
    @commnet = Comment.new
    @file = Datum.new

    # get activities
    @activities = PublicActivity::Activity.where(:trackable_id => params[:id], :key => "todo.create").first
    if (@activities.try(:owner_id))
      @user_create = User.find_by_id(@activities.owner_id).fullname
    end
    if (@activities.try(:key))
      if (@activities.key=="todo.create")
        @action = "created"
      end
    end
  end

  def create
    # binding.pry
    create! do |success, failure|
      success.html { redirect_to frontend_team_todo_list_path(team_id: resource.todo_list.team_id, id: resource.todo_list.id),
        notice: "Todo has been created." }
      failure.html {redirect_to frontend_team_path(resource.todo_list.team_id),
        notice: "Can not cread todo."}
    end
  end

  # Check done
  def update
    # update data check list
    # binding.pry
    if !resource.step_id.nil? and params[:name]!="update_position" and params[:name]!= "check_done"
      redirect_to frontend_team_todo_list_path(team_id: resource.todo_list.team_id, id: resource.todo_list.id),
      notice: "Cannot edit, delete todo in Workflow!"
      return
    end

    if params[:name]=="check_list"
      resource.update_attributes(:data_check_list => params[:list]);
    end

    @todo = Todo.find(params[:id])
    @name = params[:name]

    # Update position
    if @name=="update_position"
      @position = params[:position];
      @todo.update_attributes(:position => @position)
    # Update check done
    elsif @name=="check_done"
      if @todo.step_id.nil?
        if @todo.status=="undone"
          if @todo.parent_id.nil? or @todo.parent_id=="0"
            check_todo_late(@todo)
          elsif !@todo.parent_id.nil?
            if !(Todo.find_by_id(@todo.parent_id).status != "undone")
              # redirect_to frontend_team_todo_list_path(team_id: resource.todo_list.team_id, id: resource.todo_list.id),
              flash[:notice] = "You not check done, Todo related order todo"
            else
              check_todo_late(@todo)
            end
          elsif Todo.where(id: @todo, status: ["late","done"]).present?
            todo.update_attributes(:status => "undone", :position => 0)
            Notification.create(event: "undone",team_id: todo.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: todo.id, url: "todos/" + todo.id.to_s)
            flash[:notice] = "Todo undone"
          end
        else
          @todo.update_attributes(:status => "undone", :position => 0)
          Notification.create(event: "undone",team_id: @todo.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: @todo.id, url: "todos/" + @todo.id.to_s)
          flash[:notice] = "Todo undone"
        end

      # todo workflow
      else
        # find step previous step current
        # check done all todo lisst
        id_step_previous = StepWorkflow.find_by_id(@todo.step_id).parent_id
        todo_list_id = resource.todo_list_id
        if id_step_previous.to_s == "0"
          if @todo.status == "undone"
            check_todo_late(@todo)
          else
            flash[:notice] = "Todo in workflow ,so can't check undone"
          end
        else
          check = true;
          id_step_previous.tr('[]', '').scan( /\d+/ ).map(&:to_i).each do |item|
            if !Todo.where(todo_list_id: todo_list_id, step_id: item, status: ["done","late"]).present?
              check = false;
              break;
            end
          end
          # flash[:notice] = id_step_previous

          if check==true
            if Todo.find_by_id(params[:id]).status == "undone"
              check_todo_late(@todo)
            else
              flash[:notice] = "Todo can't check undone"
            end
          else
            flash[:notice] = "Step privious not done"
          end

        end
      end

    elsif @name=="delete"
      if @todo.update_attributes(:archived => true, :position => 0)
        Notification.create(event: "deleted",team_id: @todo.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: @todo.id, url: "todos/" + @todo.id.to_s)
        flash[:notice] = "Todo deleted"
      end
    else
      update! do |success, failure|
        success.html {
          Notification.create(event: "updated",team_id: resource.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: resource.id, url: "todos/" + resource.id.to_s)
          redirect_to frontend_team_todo_list_path(team_id: resource.todo_list.team_id, id: resource.todo_list.id),
          notice: "Todo has been update" }
        failure.html {redirect_to frontend_team_path(resource.todo_list.team_id),
          notice: "Can not update todo."}
      end
    end

  end

  private
    def notify_create
      Notification.create(event: "created",team_id: resource.todo_list.team.id , user_id: current_user.id, category: "todo", parent_id: resource.id, url: "todos/" + resource.id.to_s)
    end
  # def create
  #   binding.pry
  #   create!
  # end
end
