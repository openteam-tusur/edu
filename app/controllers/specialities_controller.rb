# encoding: utf-8

class SpecialitiesController < InheritedResourcesController
  load_resource

  actions :index

  def index
    search = Speciality.search(params[:query], params)
    @specialities = search.results
    @degree_facets = search.facet(:degree).rows
    @chair_facets = search.facet(:chair_id).rows
  end
end

