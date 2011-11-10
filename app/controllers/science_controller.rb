# encoding: utf-8

class ScienceController < CrudController
  def index
   # @specialities_facets = Speciality.search.facet(:degree).rows
  #  @publication_facets = Publication.search(nil, nil, {}, :published).facet(:kind).rows
    render :file => 'shared/science.html.erb', :layout => true
  end
end

