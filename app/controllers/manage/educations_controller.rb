class Manage::EducationsController < Manage::ApplicationController

  load_resource :except => :get_fields
  authorize_resource :class => Plan::Education

  defaults :resource_class => Plan::Education,
           :instance_name => 'education'

  actions :all, :except => [:show, :index]

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug do
      belongs_to :curriculum,
                  :param => :curriculum_id,
                  :instance_name => :curriculum,
                  :parent_class => Plan::Curriculum,
                  :finder => :find_by_slug do
        belongs_to :semester,
                    :param => :semester_id,
                    :instance_name => :semester,
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

  def get_fields
    @study = Plan::Study.find(params[:study][:id])
    render :partial => 'manage/educations/fields'
  end
end

