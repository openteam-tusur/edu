class TrainingController < CrudController
  def index
    @specialities_facets = Speciality.search.facet(:degree).rows
    @publication_facets = Publication.search(nil, nil, {}, :published).facet(:kind).rows
    render :file => 'common/training.html.erb', :layout => true
  end
end

