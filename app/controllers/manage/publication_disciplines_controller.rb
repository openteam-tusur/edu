# encoding: utf-8

class Manage::PublicationDisciplinesController < Manage::ApplicationController

  load_and_authorize_resource

  actions :all, :except => [:index, :show]

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :publication
  end

end
