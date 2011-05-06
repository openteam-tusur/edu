# encoding: utf-8

class PublicationsController < CrudController
  load_resource :except => :get_fields

  def index
    search = Publication.search(params[:query], nil, params, :published)
    @publications = search.results
    @facets = search.facet(:kind).rows
    @chair_facets = search.facet(:chair_id).rows
  end

  def show
    @publication = Publication.find(params[:id])
  end

  def get_fields
    render :text => "" and return if params[:publication][:kind].blank?
    params[:publication].delete("authors_attributes")
    params[:publication].delete("attachment_attributes")
    @publication = Publication.new(params[:publication])
    render :partial => "/publications/fields"
  end
end

