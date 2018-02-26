class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # guest user (not logged in)
      r = Role.find_by_id(user.role_id)
      if (r.name.to_s=="admin") or (r.name.to_s=="Scrum Master")  or (r.name.to_s=="Product Owner")
          can :manage, :all
      elsif user.super_role.to_s=="team" or user.super_role.to_s=="team_member"
          can :manage, :all
        # else
        #   can :manage, :all
        #   cannot :create, Team

      else
        # can :manage, Todo, { user_id: user.id  }
        can :manage, Todo
        can :manage, TodoList
        can :manage, Comment, { user_id: user.id}
        can :read, Team
      end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
      # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
