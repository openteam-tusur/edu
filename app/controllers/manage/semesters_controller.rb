# encoding: utf-8

class Manage::SemestersController < Manage::ApplicationController

  load_and_authorize_resource

  defaults :finder => :find_by_number

  actions :all, :except => [:index]

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :curriculum,
               :param => :curriculum_id,
               :instance_name => :curriculum,
               :parent_class => Curriculum,
               :finder => :find_by_slug
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end
end

