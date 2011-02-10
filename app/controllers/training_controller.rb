class TrainingController < ApplicationController
  def index
    @specialities_facets = Speciality.search.facet(:degree).rows
    @publication_facets = Publication.search.facet(:kind).rows
    render :file => "common/training.html.erb", :layout => true
  end
end
