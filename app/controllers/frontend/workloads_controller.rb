class  Frontend::WorkloadsController < FrontendController
  # inherit_resources

  before_action :check_use
  def check_use
    if !(current_user.super_role=="team" or current_user.super_role=="team_member")
      redirect_to frontend_root_path,
      notice: "You not role"
    end
  end

  class Status
    attr_accessor :late, :date, :done, :undone, :estimate ,:listtodos
    def initialize()
      @late = 0
      @done = 0
      @undone = 0
      @estimate = 0
      @listtodos = []
      # @date = Date.today
    end

    def Cal(todo,list)
      @listtodos.push(list)
      if (todo.status == "done")
        @done += 1
        @estimate += todo.estimate
      elsif (todo.status == "undone")
        @undone += 1
        @estimate += todo.estimate
      elsif (todo.status == "late")
        @late += 1
        @estimate += todo.estimate
      end
    end
    def setdate(date)
      @date = date
    end

  end

  def view_member
    # binding.pry
    @user = User.find_by_id(params[:user])
    @team = Team.find_by_id(params[:team_id])
    if (params[:date].nil?)
        date = Date.today
    else
        date = params[:date].to_date
    end

    monday = date.at_beginning_of_week
    tuesday = date.at_beginning_of_week+1.day
    webnesday = date.at_beginning_of_week+2.day
    thursday =date.at_beginning_of_week+3.day
    friday = date.at_beginning_of_week+4.day
    satuday = date.at_beginning_of_week+5.day
    sunday = date.at_beginning_of_week+6.day

    @mon = Status.new
    @mon.setdate(monday.strftime("%d/%m/%Y"))

    @tue = Status.new
    @tue.setdate(tuesday.strftime("%d/%m/%Y"))

    @web = Status.new
    @web.setdate(thursday.strftime("%d/%m/%Y"))

    @thu = Status.new
    @thu.setdate(webnesday.strftime("%d/%m/%Y"))

    @fri = Status.new
    @fri.setdate(friday.strftime("%d/%m/%Y"))

    @sat = Status.new
    @sat.setdate(satuday.strftime("%d/%m/%Y"))

    @sun = Status.new
    @sun.setdate(sunday.strftime("%d/%m/%Y"))

    @team.todo_lists.where(:archived => [nil,false]).each do |todo_list|
      todo_list.todos.where(:archived => [nil,false]).each do |todo|
        if (@user.todos.include?(todo))
          result = Array.new
          result.push("todo_list_id" => todo.todo_list_id,"id"=>todo.id, "name"=>todo.name, "todolist"=>todo_list.name, "status"=>todo.status)
          if !todo.due_date.nil?
            if (monday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @mon.Cal(todo,result)

            elsif (tuesday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @tue.Cal(todo, result)

            elsif (webnesday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @web.Cal(todo, result)

            elsif (thursday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @thu.Cal(todo, result)

            elsif (friday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @fri.Cal(todo, result)

            elsif (satuday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @sat.Cal(todo, result)

            elsif (sunday.strftime("%Y-%m-%d")==todo.due_date.strftime("%Y-%m-%d"))
              @sun.Cal(todo, result)
            end
          end
        end
      end
    end
    @list = Array.new
    @list.push("monday"=>@mon,"tuesday"=>@tue,"webnesday"=>@web,"thursday"=>@thu,"friday"=>@fri,"satuday"=>@sat,"sunday"=>@sun)
  end


  def index
    @team = Team.find_by_id(params[:team_id])
    @result = Array.new
    u = Array.new
    if params[:date].nil?
      @date = Date.today.strftime("%Y-%m-%d")
    else
      @date = params[:date]
    end

    @team.users.each do |user|
      status = Array.new
      @done = 0
      @undone = 0
      @late = 0
      @estimate = 0
      if @date.present?
        @team.todo_lists.where(:archived => [nil,false]).each do |todolist|
          todolist.todos.where(:archived => [nil,false], user_id: user.id, due_date: @date.to_date.at_beginning_of_week..@date.to_date.at_end_of_week).each do |todo_detail|
            if (todo_detail.status == "done")
              @done = @done + 1
              @estimate  += todo_detail.estimate
            elsif (todo_detail.status == "undone")

              @undone = @undone + 1
              @estimate  += todo_detail.estimate
            elsif (todo_detail.status == "late")
              @late = @late + 1
              @estimate  += todo_detail.estimate
            end
          end
        end
      # else
      #   @team.todo_lists.where(:archived => [nil,false]).each do |todolist|
      #     todolist.todos.where(:archived => [nil,false], user_id: user.id).each do |todo_detail|
      #       if (todo_detail.status == "done")
      #         @done = @done + 1
      #         @estimate  += todo_detail.estimate
      #       elsif (todo_detail.status == "undone")
      #
      #         @undone = @undone + 1
      #         @estimate  += todo_detail.estimate
      #       elsif (todo_detail.status == "late")
      #         @late = @late + 1
      #         @estimate  += todo_detail.estimate
      #       end
      #     end
      #   end
      end
      # status.push("team_id"=>params[:team_id],"id_user"=>user.id ,"user"=>user.fullname,"estimate"=>@estimate,"done"=>@done,"late"=>@late,"undone"=>@undone)
      status.push("id_user"=>user.id ,"user"=>user.fullname,"estimate"=>@estimate,"done"=>@done,"late"=>@late,"undone"=>@undone, "date" => @date)
      u.push(status)
      # tim todo cua thang user nay
      # thuoc team nay
    end
    @result.push(u)
    u = Array.new
    end

  # def view_team
  #   @team = Team.find_by_id(params[:team_id])
  #   @result = Array.new
  #   u = Array.new
  #   @date = params[:date]
  #   @result.push("team"=>@team.name)
  #   @team.users.each do |user|
  #     status = Array.new
  #     @done = 0
  #     @undone = 0
  #     @late = 0
  #     @estimate = 0
  #     if !params[:date].nil?
  #       @team.todo_lists.where(:archived => [nil,false]).each do |todolist|
  #         todolist.todos.where(:archived => [nil,false], user_id: user.id, due_date: @date.to_date.at_beginning_of_week..@date.to_date.at_end_of_week).each do |todo_detail|
  #           if (todo_detail.status == "done")
  #             @done = @done + 1
  #             @estimate  += todo_detail.estimate
  #           elsif (todo_detail.status == "undone")
  #
  #             @undone = @undone + 1
  #             @estimate  += todo_detail.estimate
  #           elsif (todo_detail.status == "late")
  #             @late = @late + 1
  #             @estimate  += todo_detail.estimate
  #           end
  #         end
  #       end
  #     else
  #       @team.todo_lists.where(:archived => [nil,false]).each do |todolist|
  #         todolist.todos.where(:archived => [nil,false], user_id: user.id).each do |todo_detail|
  #           if (todo_detail.status == "done")
  #             @done = @done + 1
  #             @estimate  += todo_detail.estimate
  #           elsif (todo_detail.status == "undone")
  #
  #             @undone = @undone + 1
  #             @estimate  += todo_detail.estimate
  #           elsif (todo_detail.status == "late")
  #             @late = @late + 1
  #             @estimate  += todo_detail.estimate
  #           end
  #         end
  #       end
  #     end
  #     status.push("team_id"=>params[:team_id],"id_user"=>user.id ,"user"=>user.fullname,"estimate"=>@estimate,"done"=>@done,"late"=>@late,"undone"=>@undone)
  #     u.push(status)
  #     # tim todo cua thang user nay
  #     # thuoc team nay
  #   end
  #   @result.push(u)
  #   u = Array.new
  #   respond_to do |format|
  #     format.any(:html, :js, :json) { render json: @result.to_json }
  #   end
  # end

end
