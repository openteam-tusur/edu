class Manage::PublicationsController < Manage::ApplicationController

  load_resource :except => :get_fields
  authorize_resource :class=> Publication

  custom_actions :resource => [:transit, :delete]

  belongs_to :chair, :finder => :find_by_slug

  def index
    search = Publication.search(params[:query], @chair, params)
    @publications = search.results
    @facets = search.facet(:kind).rows
  end

  def transit
    transit! do
      @publication.send "#{params[:event]}!" if @publication.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end

  def get_fields
    @publication = Publication.find(params[:id]) if params[:id]
    @publication ||= Publication.new

    render :partial => "/manage/publications/#{@publication.fields_for_kind(params[:kind])}"
  end

end

