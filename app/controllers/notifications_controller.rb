class NotificationsController < ApplicationController
  before_action :authenticate_any!
  def index
    notification_ids = []
    current_user.teams.each do |team|
      Notification.where(:team_id => team.id, category: "todo list").each do |noti|
        notification_ids.push(noti.id)
      end
    end
    current_user.todos.each do |todo|
      Notification.where(:parent_id => todo.id).each do |noti|
        notification_ids.push(noti.id)
      end
    end

    @count =   Notification.where("id IN (?) AND user_id != ?", notification_ids, current_user.id).count
    @notifications = Array.new
    if params[:name]=="more"
      # Notification.where(:id => notification_ids).order("created_at DESC").limit(5).offset(params[:offset]).each do |notification|
      Notification.where("id IN (?) AND user_id != ?", notification_ids, current_user.id).order("created_at DESC").limit(10).offset(params[:offset]).each do |notification|
        user = User.find_by_id(notification.user_id).fullname
        event = notification.event
        category = notification.category
        date = notification.created_at.strftime("%d %b. %Y")
        if notification.category.to_s=="comment"
          todo = Todo.find_by_id(notification.parent_id)
          name = todo.name
          todo_list_name = todo.todo_list.name
        else
          if notification.category.to_s=="todo"
            todo = Todo.find_by_id(notification.parent_id)
            name = todo.name
              todo_list_name = todo.todo_list.name
          elsif notification.category.to_s=="todo list"
            name = TodoList.find_by_id(notification.parent_id).name
            todo_list_name = name
          end
        end
        if notification.view_user_id.nil?
          @notifications.push('parent_id'=> todo_list_name,"user_list" =>"[]", "id" => notification.id,"user" => user, "event" => event, "category" => category, "name" => name, "date" => date, "url" => notification.url)
        else
          @notifications.push('parent_id'=> todo_list_name,"user_list" =>notification.view_user_id, "id" => notification.id,"user" => user, "event" => event, "category" => category, "name" => name, "date" => date, "url" => notification.url)
        end

      end
      respond_to do |format|
        format.any(:html, :js, :json) { render json: @notifications.to_json }
      end

    else
      # Notification.where(:id => notification_ids).order("created_at DESC").limit(10).each do |notification|
      Notification.where("id IN (?) AND user_id != ?", notification_ids, current_user.id).order("created_at DESC").limit(20).each do |notification|
        user = User.find_by_id(notification.user_id).fullname
        event = notification.event
        category = notification.category
        date = notification.created_at.strftime("%d %b. %Y")
        if notification.category.to_s=="comment"
          todo = Todo.find_by_id(notification.parent_id)
          if todo.present?
            name = todo.name
            todo_list_name = todo.todo_list.name
          end
        else
          if notification.category.to_s=="todo"
            todo = Todo.find_by_id(notification.parent_id)
            if todo.present?
              name = todo.name
              todo_list_name = todo.todo_list.name
            end
          elsif notification.category.to_s=="todo list"
            name = TodoList.find_by_id(notification.parent_id).name
            todo_list_name = name
          end
        end
        @notifications.push('parent_id'=> todo_list_name,"user_list" =>notification.view_user_id, "id" => notification.id,"user" => user, "event" => event, "category" => category, "name" => name, "date" => date, "url" => notification.url)
      end
    end
  end

  def update
    if params[:name]=="view"
      noti = Notification.find_by_id(params[:id])
      id_user = params[:view_user_id].to_i
      list_id = []
      count = false
      if !noti.view_user_id.nil?
        noti.view_user_id.tr('[]', '').scan( /\d+/ ).map(&:to_i).each do |item|
          list_id.push(item)
        end
      end
      list_id.push(id_user)
      noti.update_attributes(view_user_id: list_id)
    end
  end
  # def index
  #   notification_ids = []
  #   current_user.teams.each do |team|
  #     notification_ids.push(team.id)
  #     team.todo_lists.each do |todo_list|
  #       notification_ids.push(todo_list.id)
  #     end
  #   end
  #   current_user.todos.each do |todo|
  #     notification_ids.push(todo.id)
  #   end
  #   # notification_ids = notification_ids.uniq
  #   @notifications = Notification.where(:parent_id => notification_ids).order("created_at DESC")
  # end
  # Team mà memeber thuộc
    # todo list thuộc team
  # todo mà nó làm or nó được replace
    # Comment thuộc todo như trên
end
