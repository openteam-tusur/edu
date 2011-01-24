class SemestersController < InheritedResources::Base
  defaults :resource_class => Plan::Semester,
           :instance_name => :semester,
           :finder => :find_by_number

  actions :index, :show

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug do
      belongs_to :curriculum,
                 :param => :curriculum_id,
                 :instance_name => :curriculum,
                 :parent_class => Plan::Curriculum,
                 :finder => :find_by_slug
    end
  end
end

