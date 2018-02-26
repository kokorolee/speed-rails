class  Frontend::MembersController < FrontendController
  # load_and_authorize_resource
  before_action :check_use
  def check_use
    if !(current_user.super_role=="member" or current_user.super_role=="team_member")
      redirect_to frontend_root_path,
      notice: "You not role"
    end
  end
  # def index
  #   member_ids = []
  #   teams = current_user.teams
  #   teams.each do |team|
  #     user_ids = team.users.pluck(:id)
  #     member_ids = member_ids + user_ids
  #   end
  #   member_ids = member_ids.uniq
  #   @members =  User.includes(:teams).where(id: member_ids)
  # end
end
