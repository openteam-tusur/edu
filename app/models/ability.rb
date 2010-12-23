class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.roles.include?(:admin)
      can :manage, :all
    end

    can :manage, Human, :user_id => user.id
    can :manage, Roles::Student, :human_id => user.human.id if user.human
    can :manage, Roles::Teacher, :human_id => user.human.id if user.human

    can :download, Attachment do |attachment|
      attachment.resource.access_free?
    end

    can :read, :all
  end
end

