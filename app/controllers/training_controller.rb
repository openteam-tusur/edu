class TrainingController < ApplicationController
  def index
    @curriculums = Plan::Curriculum.published
    @publication_facets = Publication.search.facet(:kind).rows
    render :file => "common/training.html.erb", :layout => true
  end
end

