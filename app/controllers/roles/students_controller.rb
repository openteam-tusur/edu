# encoding: utf-8

class Roles::StudentsController < RolesController
  load_and_authorize_resource :class => Roles::Student

  defaults :resource_class => Roles::Student,
           :instance_name => :roles_student

  def create
      create! { human_path }
  end

  def new
    redirect_to human_path, :alert => t(:fill_human) unless current_user.human.filled?
  end
end

