# encoding: utf-8

class Manage::EmployeesController < Manage::ApplicationController

  load_and_authorize_resource :class => 'Human'

  actions :all, :except => [:show]

  defaults :resource_class => Human,
           :instance_name => 'employee'

  belongs_to :chair, :finder => :find_by_slug

  def index
    @employees = Human.find_accepted_employees_in_chair(params[:query], params[:page], @chair)
  end

  def new
    @employee = Human.new(:chair_id => @chair.id)
  end

  def create
    @employee = @chair.create_employee(params[:employee])
    if @employee.new_record?
      render :action => :new
    else
      redirect_to collection_path
    end
  end

  def edit
    @employee = @chair.find_employee(params[:id])
  end

  def update
    @employee = @chair.update_employee(params[:id], params[:employee])
    if @employee.errors.empty?
      redirect_to collection_path
    else
      render :action => :edit
    end
  end
end

