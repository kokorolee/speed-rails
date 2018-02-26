class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  # def perform(counter,notification, user)
  #   ActionCable.server.broadcast 'notification_channel',user_id: user,  counter: render_counter(counter), notification: render_notification(notification)
  #   # case notification.category # a_variable is the variable we want to compare
  #   # when "todo"
  #   #   if Team.find_by_id(notification.parent_id).include?(current_user)
  #   #     ActionCable.server.broadcast 'notification_channel',  counter: render_counter(counter), notification: render_notification(notification)
  #   #   end
  #   # when "todo list"    #compare to 2
  #   #
  #   # else
  #   #
  #   # end
  # end

  # private
  #   def render_counter(counter)
  #     ApplicationController.renderer.render(partial: 'notifications/counter', locals: { counter: counter })
  #   end
  #
  #   def render_notification(notification)
  #     ApplicationController.renderer.render(partial: 'notifications/realtime_notification', locals: { notification: notification })
  #   end
end
