class EducationsController < InheritedResources::Base

  load_and_authorize_resource

  defaults :resource_class => Plan::Education,
           :instance_name => 'education'

  actions :show, :index

  belongs_to :speciality, :finder => :find_by_slug do
    belongs_to :curriculum,
                :param => :curriculum_id,
                :instance_name => :curriculum,
                :parent_class => Plan::Curriculum,
                :finder => :find_by_slug do
      belongs_to :semester,
                 :instance_name => :semester,
                 :parent_class => Plan::Semester,
                 :finder => :find_by_number
    end
  end
end

