# encoding: utf-8

class Roles::TeachersController < RolesController
  load_and_authorize_resource :class => Roles::Teacher

  defaults :resource_class => Roles::Teacher,
           :instance_name => :roles_teacher

  def create
      create! { human_path }
  end

  def new
    redirect_to human_path, :alert => t(:fill_human) unless current_user.human.filled?
  end
end

