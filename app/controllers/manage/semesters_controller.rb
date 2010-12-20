class Manage::SemestersController < Manage::ApplicationController

  defaults :resource_class => Plan::Semester,
           :instance_name => :plan_semester

  belongs_to :chair, :shallow => true do
    belongs_to :speciality do
      belongs_to :curriculum, :param => :curriculum_id, :instance_name => :plan_curriculum, :parent_class => Plan::Curriculum
    end
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end

