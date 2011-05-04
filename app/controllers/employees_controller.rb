# encoding: utf-8

class EmployeesController < RolesController
  load_and_authorize_resource

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

