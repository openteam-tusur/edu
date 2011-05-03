# encoding: utf-8

class Manage::EducationsController < Manage::ApplicationController

  load_and_authorize_resource

  actions :all, :except => [:show, :index]

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug do
      belongs_to :curriculum,
                  :param => :curriculum_id,
                  :instance_name => :curriculum,
                  :parent_class => Curriculum,
                  :finder => :find_by_slug do
        belongs_to :semester,
                    :param => :semester_id,
                    :instance_name => :semester,
                    :parent_class => Semester,
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

