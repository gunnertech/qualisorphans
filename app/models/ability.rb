class Ability
  include CanCan::Ability

  def initialize(user)
    
    
    
    
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.has_role?('admin')
      can :manage, :all
    else 
      can :read, Post
      can :read, Organization
      can :read, Orphan
      
      if !user.new_record?
        organization_ids = Organization.with_role("admin", user).empty? ? [] : Organization.with_role("admin", user).pluck("id")
        subscription_ids = user.subscriptions.empty? ? [] : user.subscriptions.pluck("id")
        can :manage, :organization, id: (organization_ids.empty? ? [0] : organization_ids)
        can :create, Subscription        
        can :manage, :subscription, id: (subscription_ids.empty? ? [0] : subscription_ids)
      end
    end
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
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
