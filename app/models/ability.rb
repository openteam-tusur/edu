# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.roles.include?(:admin)
      can :manage, :all
    end

    can :manage, Human, :user_id => user.id
    can :manage, Student, :human_id => user.human.id if user.human
    can :manage, Employee, :human_id => user.human.id if user.human
    can :manage, Graduate, :human_id => user.human.id if user.human

    can :download, Attachment do |attachment|
      attachment.resource.access_free? || user.human.roles.any?
    end

    can :read, :all
  end
end

