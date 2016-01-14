class Ability
  include CanCan::Ability

  def initialize(user) # means current_user
  
    user ||= User.new # guest user (not logged in)
    
    if user.admin?
      can :manage, :all
    else
      cannot :manage, :all
    end
  end
end
