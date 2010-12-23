class Manage::TeachersController < Manage::ApplicationController

  load_and_authorize_resource :class => Human

  defaults :resource_class => Human,
           :instance_name => 'teacher'

  belongs_to :chair, :finder => :find_by_slug

  def new
    @teacher = Human.new
  end

  def create
    @teacher = @chair.create_teacher(params[:teacher])
    if @teacher.new_record?
      render :action => :new
    else
      redirect_to collection_path
    end
  end

  def edit
    @teacher = @chair.find_teacher(params[:id])
  end

  def update
    @teacher = @chair.update_teacher(params[:id], params[:teacher])
    if @teacher.errors.empty?
      redirect_to collection_path
    else
      render :action => :edit
    end
  end
end
