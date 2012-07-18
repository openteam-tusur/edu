class Manage::LicensesController < Manage::ApplicationController
  defaults :resource_class => Publication, :collection_name => 'publications'
  actions :index

  load_and_authorize_resource :class => "Publication"

  def index
    search = Publication.search(params[:query], nil, params.merge(:per_page => 20))
    @publications = search.results
    @facets = search.facet(:kind).rows
    @chair_facets = search.facet(:chair_id).rows
    @state_facets = search.facet(:state).rows

    @comment_facets = search.facet(:with_comment).rows.inject({}) do |hash, facet|
      hash[facet.value] = facet.count; hash
    end
  end

  def roster
    mime_type = MIME::Types.of('odt').first.content_type
    data = Publication.generate_data('roster.ods', Publication.roster_data)
    send_data data, :type => mime_type, :filename => 'roster.ods'
  end
end
