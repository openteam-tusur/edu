class Ability
  include CanCan::Ability

  def initialize(user)

   user ||= User.new
    if user.roles.include?(:admin)
      can :manage, :all
    end

    can :manage, :human, :user_id => user.id

    can :read, :all
  end
end

