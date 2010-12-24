# encoding: utf-8

class Roles::TeachersController < RolesController
  load_and_authorize_resource :class => Roles::Teacher

  defaults :resource_class => Roles::Teacher,
           :instance_name => :roles_teacher

  def create
    create! do
      RoleMailer.role_create_notification(resource).deliver!
      human_path
    end
  end

  def update
    update! do
     RoleMailer.role_update_notification(resource).deliver!
     human_path
    end
  end
end

