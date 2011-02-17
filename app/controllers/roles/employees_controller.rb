# encoding: utf-8

class Roles::EmployeesController < RolesController
  load_and_authorize_resource :class => Roles::Employee

  defaults :resource_class => Roles::Employee,
           :instance_name => :roles_employee

  def create
    create! do
      RoleMailer.role_create_notification(resource).deliver!
      profile_path
    end
  end

  def update
    update! do
     RoleMailer.role_update_notification(resource).deliver!
     profile_path
    end
  end
end

