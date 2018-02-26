class Frontend::CheckListsController < FrontendController
  inherit_resources
  assign_params :name, :desc, :team_id
  def show
    # @todos = resource.todos.order("position,due_date ASC")
  end
  def destroy
    destroy! do |success, failure|
      success.html {
        StepCheckList.where(check_list_id: resource.id).destroy_all
        redirect_to frontend_team_check_lists_path(resource.team_id),
        notice: "Check list deleted" }
      failure.html {redirect_to frontend_team_check_lists_path(resource.team_id),
        notice: "Can not delete check list."}
    end
  end
  def create
    create! do |success, failure|
      success.html {
        (1..params[:stt].to_i).each do |i|
          name ="step"+i.to_s
          @step = StepCheckList.new
          @step.name = params[name.to_sym]
          @step.check_list_id = resource.id
          @step.no = i
          @step.save
        end
        redirect_to frontend_team_check_lists_path(resource.team_id),
        notice: "Todo list has been updated." }
      failure.html {redirect_to frontend_team_check_lists_path(resource.team_id),
        notice: "Can not update Todo list."}
      end
    end

    def update
      update! do |success, failure|
        success.html {
          StepCheckList.where(check_list_id: resource.id).each do |step|
            step.delete
          end
         
          (1..params[:stt].to_i).each do |i|
            name ="step_name_"+i.to_s
            @step = StepCheckList.new
            @step.name = params[name.to_sym]
            @step.check_list_id = resource.id
            @step.no = i
            @step.save
          end
          redirect_to frontend_team_check_lists_path(resource.team_id),
          notice: "Todo list has been updated." }
        failure.html {redirect_to frontend_team_check_lists_path(resource.team_id),
          notice: "Can not update Todo list."}
        end
      end
end
