class Manage::EducationsController < Manage::ApplicationController
  inherit_resources

  defaults :resource_class => Plan::Education,
           :instance_name => 'plan_education'

  belongs_to :chair, :shallow => true do
    belongs_to :speciality do
      belongs_to :semester, :param => :semester_id, :instance_name => :semester, :parent_class => Plan::Semester
    end
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end
