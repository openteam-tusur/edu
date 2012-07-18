# encoding: utf-8

class Manage::PublicationsController < Manage::ApplicationController
  load_resource      :except => :get_fields
  authorize_resource :class  => 'Publication'

  custom_actions :resource => [:transit, :delete]

  belongs_to :chair, :finder => :find_by_slug

  # TODO: http://issues.openteam.ru/issues/6765
  def index
    search = Publication.search(params[:query], nil, params.merge(:chair_id => @chair.id))
    @publications = search.results
    @facets = search.facet(:kind).rows
    @state_facets = search.facet(:state).rows

    @comment_facets = search.facet(:with_comment).rows.inject({}) do |hash, facet|
      hash[facet.value] = facet.count; hash
    end
  end

  def transit
    transit! do
      @publication.send "#{params[:event]}!" if @publication.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to resource_path and return
    end
  end

  def get_fields
    render :text => "" and return if params[:publication][:kind].blank?
    params[:publication].delete("authors_attributes")
    params[:publication].delete("attachment_attributes")
    @publication = Publication.new(params[:publication])
    render :partial => "crud/manage/publications/fields"
  end

  def to_report
    @chair = Chair.find_by_slug(params[:chair_id])
    @mime_type = MIME::Types.of('odt').first.content_type

    begin
      data = Publication.generate_data('publication.odt', @publication.to_report)
      send_data data, :type => @mime_type, :filename => 'publication.odt'
    rescue Exception => e
      redirect_to manage_chair_publication_path(@chair, @publication)
    end
  end

end

