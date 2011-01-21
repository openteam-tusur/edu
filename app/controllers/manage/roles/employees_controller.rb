# encoding: utf-8

class Roles::EmployeesController < RolesController
  load_and_authorize_resource :class => Roles::Employee

  defaults :resource_class => Roles::Employee,
           :instance_name => :roles_employee

end

