# encoding: utf-8

class Roles::StudentsController < RolesController
  load_and_authorize_resource :class => Roles::Student

  defaults :resource_class => Roles::Student,
           :instance_name => :roles_student
end

