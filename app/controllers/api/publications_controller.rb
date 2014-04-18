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
      { :id => publication.id, :title => publication.title, :url => publication_url(publication) }
    end

    render :json => data.to_json
  end
end
