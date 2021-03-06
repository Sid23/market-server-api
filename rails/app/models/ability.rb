class Ability
  include CanCan::Ability

  def initialize(user)
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
    #logger.debug("-------------------- Initialized roles --------------------------")
    #logger.debug(user)
    
    # Defina alias actions for crud
    alias_action :index, :create, :show, :update, :destroy, to: :crud

    user ||= User.new()
    if user.admin?
      # User is an Admin
      can [:index, :show], [User, Admin]
      # Admin can update/destroy only itself
      can [:update, :destroy], Admin, id: user.id
      # Admin can create/update/delete all users
      can [:create, :update, :destroy], User

      can :crud, Course
    else
      # Ordinary User
      cannot :manage, Admin
      can [:index, :show], [User, Course]
      # User can update/destroy only itseld
      can [:update, :destroy], User, id: user.id
    end
  end
end
