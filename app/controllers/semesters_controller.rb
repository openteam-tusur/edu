class SemestersController < InheritedResources::Base
  load_resource

  defaults :resource_class => Semester,
           :instance_name => :semester,
           :finder => :find_by_number

  actions :show

  belongs_to :speciality, :finder => :find_by_slug do
    belongs_to :curriculum,
               :param => :curriculum_id,
               :instance_name => :curriculum,
               :parent_class => Curriculum,
               :finder => :find_by_slug
  end
end

