class Ability
  include CanCan::Ability

  def initialize(user)

   user ||= User.new
    if user.roles.include?(:admin)
      can :manage, :all
    end

    can :read, :all
  end
end

