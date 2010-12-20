class Manage::SemestersController < Manage::ApplicationController
  inherit_resources

  defaults :resource_class => Plan::Semester,
           :instance_name => :plan_semester

  belongs_to :chair, :shallow => true do
    belongs_to :speciality
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end
