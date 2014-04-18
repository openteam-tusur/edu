class Api::PublicationsController < ActionController::Base
  layout :false

  respond_to :json

  def index
    search = Sunspot.search(Publication) do
      keywords params[:q]

      without :kind, :work_programm
      with :state, :published
    end

    data = search.results.map do |publication|
      { :title => publication.to_s, :url => publication_url(publication) }
    end

    render :json => data.to_json, :callback => params['callback']
  end
end
