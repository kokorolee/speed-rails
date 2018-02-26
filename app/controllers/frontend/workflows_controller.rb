class  Frontend::WorkflowsController < FrontendController
  inherit_resources
  # load_and_authorize_resource :except => :create
  assign_params :name, :parent_id

  before_action :check_routes, only: ['show']
  # khong cho user vao team k thuoc
  def check_routes
    if params[:team_id].nil?
      redirect_to frontend_teams_path,
      notice: "URL not found"
    end
  end

  def index
    if params[:name]=="delete"
      Workflow.find_by_id(params[:id_workflow]).update_attributes(:archived => true)
      flash[:notice] = "Deleted workflow."
    end
  end

  def create
    create! do |success, failure|
      # binding.pry
      success.html {

        id = 0;
        (1..params[:stt].to_i).each do |i|
          name = "step"+i.to_s
          date = "date"+i.to_s
          deadline = "deadline"+i.to_s
          parent_id = "parent_id"+i.to_s
          if !params[name.to_sym].nil?
            @step1 = StepWorkflow.new
            @step1.workflow_id = resource.id
            @step1.name = params[name.to_sym]
            @step1.estimate = params[date.to_sym]
            if i==1
              @step1.parent_id = 0
              if !StepWorkflow.last.nil?
                id = StepWorkflow.last.id
              else
                id = 0
              end
            else
              parent_id_list = Array.new
              string = ""
              str = ""
              string = params[parent_id.to_sym].to_s
              string.split(',').each do |item|
                parent_id_list.push((item.to_i+id).to_s)
              end

              @step1.parent_id = parent_id_list
            end
            @step1.save
          end
        end
        redirect_to frontend_team_workflows_path(team_id:resource.parent_id, id: resource.id),
        notice: "Workflow has been created." }
      failure.html {redirect_to frontend_team_workflows_path(team_id: resource.parent_id),
        notice: "Can not create Workflow."}
    end

  end

  def update
    update! do |success, failure|
      success.html {
        StepWorkflow.where(:workflow_id => params[:id]).each do |step|
          name = "step_name_" + step.id.to_s
          estimate = "step_estimate_" + step.id.to_s
          parent_id = "parent_id"+step.id.to_s
          step.update_attributes(name: params[name.to_sym], estimate: params[estimate.to_sym], parent_id: params[parent_id.to_sym])
        end
        redirect_to frontend_team_workflows_path(team_id: resource.parent_id),
        notice: "Workflow has been updated." }
      failure.html {redirect_to frontend_team_path(resource.id),
        notice: "Can not update workflow."}
    end
  end

  def show
    todolist_id = Array.new
    TodoList.where(category: "workflow", parent_id: params[:id]).each do |todolist|
      todolist_id.push("id"=>todolist.id.to_s)
    end

    if params[:name]=="get_id"
      respond_to do |format|
        format.any(:html, :js, :json) { render json: todolist_id.to_json }
      end
    end

    if params[:name]=="get-view"
      list = Array.new
      TodoList.where(category: "workflow", parent_id: params[:id], archived: [false, nil]).each do |todolist|
        # 1 danh sach viec, tiem viec done gan day nhat
        name = ""
        position = ""
        user = ""
        due_date = ""
        done = false
        id_todo = ""

        todolist.todos.order("id ASC").each do |todo|
          if todo.status == "undone"
            position = "name-"+todolist.id.to_s+"-"+todo.step_id.to_s
            name = todo.name
            user = todo.user.fullname
            due_date = '['+todo.due_date.strftime("%d/%m/%Y")+']'
            done = false
            break
          end
          id_todo = todo.id
          done = true
          position = "name-"+todolist.id.to_s+"-"+todo.step_id.to_s
          name = todo.name
          user = todo.user.fullname
          due_date = '['+todo.due_date.strftime("%d/%m/%Y")+']'
        end

        if done==true
          list.push(id_todo: id_todo,"id"=>"name-"+todolist.id.to_s, "position" => position, "name" => user, "due_date" => due_date, 'finish' => "last")
        else
          list.push("id"=>"name-"+todolist.id.to_s, "position" => position, "name" => user, "due_date" => due_date, 'finish' => "")
        end
      end
      respond_to do |format|
        format.any(:html, :js, :json) { render json: list.to_json }
      end
    end
  end
end
# t.integer "parent_id"
# t.integer "workflow_id"
# t.string "name"
# t.datetime "estimate"
