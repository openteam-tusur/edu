class CurriculumsController < InheritedResources::Base
  load_resource :class => Plan::Curriculum

  defaults :resource_class => Plan::Curriculum,
           :instance_name => :curriculum,
           :finder => :find_by_slug

  actions :index, :show

#  def index
#    @grouped_specialities = Chair.all.map { |chair| chair.grouped_specialities }
#  end

  def index
    p search = Plan::Curriculum.search(params[:query], @chair, params)
    @curriculums = search.results
#    @facets = search.facet(:study).rows
#    @chair_facets = search.facet(:chair_id).rows
  end

end

