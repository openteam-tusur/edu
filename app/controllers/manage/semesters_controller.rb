class Manage::SemestersController < Manage::ApplicationController

  defaults :resource_class => Plan::Semester,
           :instance_name => :plan_semester

  belongs_to :chair, :shallow => true do
    belongs_to :curriculum
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end

