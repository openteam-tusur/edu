# encoding: utf-8

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :read, :all

    if user.roles.include?(:admin)
      can :manage, :all
    end

    cannot [:create, :edit, :delete, :destroy, :new], Chair
    can :manage, Human,    :user_id  => user.id
    can :manage, Student,  :human_id => user.human.id if user.human
    can :manage, Employee, :human_id => user.human.id if user.human
    can :manage, Graduate, :human_id => user.human.id if user.human
    can :manage, Postgraduate, :human_id => user.human.id if user.human

    can :download, Attachment do |attachment|
      attachment.resource.access_free? || user.human.roles.accepted.any?
    end
  end
end

