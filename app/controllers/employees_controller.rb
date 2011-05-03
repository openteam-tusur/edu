# encoding: utf-8

class EmployeesController < CrudController
  actions :show

  defaults :resource_class => Human,
           :instance_name => 'employee'

  belongs_to :chair, :finder => :find_by_slug

  def index
    @employees = Human.find_accepted_employees_in_chair(params[:query], params[:page], @chair)
  end
end

