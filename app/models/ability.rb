class Ability
  include CanCan::Ability

  def initialize(user)
   user ||= User.new
    if user.roles.include?(:admin)
      can :manage, :all
    end

    can :manage, Human, :user_id => user.id
    can :create, Roles::Student
    can :create, Roles::Teacher

    can :download, Attachment do |attachment|
      attachment.resource.access_free?
    end

    can :read, :all
  end
end

