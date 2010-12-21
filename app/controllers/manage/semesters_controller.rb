class Manage::SemestersController < Manage::ApplicationController

  load_and_authorize_resource

  defaults :resource_class => Plan::Semester,
           :instance_name => :semester,
           :finder => :find_by_number

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug do
      belongs_to :curriculum,
                 :param => :curriculum_id,
                 :instance_name => :curriculum,
                 :parent_class => Plan::Curriculum,
                 :finder => :find_by_study
    end
  end

  def index
    index! do
      redirect_to parent_path
    end
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end

