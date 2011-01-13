class Manage::ResourceEducationsController < Manage::ApplicationController
  load_and_authorize_resource

  actions :all, :except => [:index, :show]

  belongs_to :chair, :finder => :find_by_slug do
    polymorphic_belongs_to :work_programm
  end
end
