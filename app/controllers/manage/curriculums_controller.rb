class Manage::CurriculumsController < Manage::ApplicationController

  defaults :resource_class => Plan::Curriculum,
           :instance_name => :plan_curriculum

  belongs_to :chair, :shallow => true do
    belongs_to :speciality
  end
end
