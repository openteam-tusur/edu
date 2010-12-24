# encoding: utf-8

class Roles::TeachersController < RolesController
  load_and_authorize_resource :class => Roles::Teacher

  defaults :resource_class => Roles::Teacher,
           :instance_name => :roles_teacher
end

