class Ability
  include CanCan::Ability

  def initialize(user)

   user ||= User.new
    if user.roles.include?(:admin)
      can :manage, :all
    end

    can :read, :all

    can :create, User
    can :destroy, User, :id => user.id
  end
end

