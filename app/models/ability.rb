class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, Recipe

    if user.id
      can :manage, Recipe
    end
  end
end
