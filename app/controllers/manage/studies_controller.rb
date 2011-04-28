class Manage::StudiesController < Manage::ApplicationController
  load_and_authorize_resource

  defaults :resource_class => Study,
           :instance_name => 'study'

  actions :all, :except => [:index, :show]

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :curriculum,
                :param => :curriculum_id,
                :instance_name => :curriculum,
                :parent_class => Curriculum,
                :finder => :find_by_slug
  end

  def create
    create! { 
      p @study
      parent_path(:anchor => @study.cycle) }
  end

  def update
    update! { parent_path(:anchor => @study.cycle) }
  end

end

