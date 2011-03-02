class StudiesController < InheritedResources::Base
  load_resource

  defaults :resource_class => Plan::Study,
           :instance_name => 'study'

  actions :index, :show

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :curriculum,
               :param => :curriculum_id,
               :instance_name => :curriculum,
               :parent_class => Plan::Curriculum,
               :finder => :find_by_slug
  end

end

