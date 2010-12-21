class Manage::PlanEducationsController < Manage::ApplicationController
  inherit_resources

  defaults :resource_class => Plan::Education,
           :instance_name => 'plan_education'

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug do
      belongs_to :plan_curriculum,
                  :param => :plan_curriculum_id,
                  :instance_name => :plan_curriculum,
                  :parent_class => Plan::Curriculum,
                  :finder => :find_by_study do
        belongs_to :plan_semester,
                    :param => :plan_semester_id,
                    :instance_name => :plan_semester,
                    :parent_class => Plan::Semester,
                    :finder => :find_by_number
      end
    end
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end
