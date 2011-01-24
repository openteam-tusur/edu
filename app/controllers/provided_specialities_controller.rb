# encoding: utf-8
class ProvidedSpecialitiesController < InheritedResources::Base
  load_and_authorize_resource :class => "Chair"
  actions :index, :show

  belongs_to :chair, :finder => :find_by_slug

  def index
    @provided_specialities = @chair.grouped_provided_specialities
  end

end

