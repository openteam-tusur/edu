# encoding: utf-8

class Roles::StudentsController < RolesController
  load_and_authorize_resource :class => Roles::Student

  defaults :resource_class => Roles::Student,
           :instance_name => :roles_student

  def create
    if @roles_student.save
      @roles_student.check_by_contingent

      redirect_to profile_path
    else
      render :action => 'new'
    end
  end

end

