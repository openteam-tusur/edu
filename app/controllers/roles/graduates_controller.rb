# encoding: utf-8

class Roles::GraduatesController < RolesController
  load_and_authorize_resource :class => Roles::Graduate

  defaults :resource_class => Roles::Graduate,
           :instance_name => :roles_graduate

end

