# encoding: utf-8
class Manage::ProvidedSpecialitiesController < Manage::ApplicationController
  load_and_authorize_resource :class => 'Chair'
  actions :only => []

  belongs_to :chair, :finder => :find_by_slug

  def index
    @provided_specialities = @chair.grouped_provided_specialities
  end

end
