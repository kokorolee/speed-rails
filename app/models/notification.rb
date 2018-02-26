class Notification < ApplicationRecord
  has_and_belongs_to_many :users


  # after_create_commit {
  #   user = Array.new
  #   if self.category=="todo list"
  #     Team.find_by_id(self.team_id).users.each do |u|
  #       user.push(u.id)
  #     end
  #   else
  #     user.push(Todo.find_by_id(parent_id).user_id)
  #   end
  #   NotificationBroadcastJob.perform_later(Notification.count,self,user)}
end
