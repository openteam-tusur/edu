class PublicationsController < InheritedResources::Base

  defaults :resource_class => Publication
  load_resource :except => :get_fields

  belongs_to :chair, :finder => :find_by_slug

  def index
    search = Publication.search(params[:query], @chair, params)
    @publications = search.results
    @facets = search.facet(:kind).rows
  end

  def get_fields
    render :text => "" and return if params[:publication][:kind].blank?
    params[:publication].delete("authors_attributes")
    params[:publication].delete("attachment_attributes")
    @publication = Publication.new(params[:publication])
    render :partial => "/publications/fields"
  end

end

