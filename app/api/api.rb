class Api < Grape::API
  class PublicationEntity < Grape::Entity
    expose :id
    expose :title
    expose :volume
    expose :year
    expose :kind
    expose :author_ids
    expose(:created_at) { |pub, _| pub.created_at.to_i }
    expose(:updated_at) { |pub, _| pub.updated_at.to_i }
  end

  class AuthorEntity < Grape::Entity
    expose :id
    expose(:surname,    :if => ->(a, _) { a.human }) { |a, _| a.human.try :surname }
    expose(:name,       :if => ->(a, _) { a.human }) { |a, _| a.human.try :name }
    expose(:patronymic, :if => ->(a, _) { a.human }) { |a, _| a.human.try :patronymic }
    expose(:roles,      :if => ->(a, _) { a.human }) { |a, _| a.human.try(:roles).try(:delete_if, &:blank?).try(:map, &:post) }

    expose(:created_at) { |pub, _| pub.created_at.to_i }
    expose(:updated_at) { |pub, _| pub.updated_at.to_i }
  end

  prefix :api

  rescue_from :all

  helpers do
    def publications_basic
      #Publication.joins(:authors).where('authors.human_id IS NOT NULL').select('distinct publications.*').order(:id)
      Publication.order(:id)
    end
  end

  resource :publications do
    get '/' do
      present publications_basic, :with => PublicationEntity
    end

    get '/kind/:kind' do
      present publications_basic.where('publications.kind = ?', params[:kind]), :with => PublicationEntity
    end

    get '/:id' do
      present Publication.find(params[:id]), :with => PublicationEntity
    end

    get '/since/:date' do
      present publications_basic.where('publications.created_at > :date OR publications.updated_at > :date', :date => Time.zone.parse(params[:date])), :with => PublicationEntity
    end
  end

  resource :authors do
    get '/' do
      present Author.order(:id).select(&:human), :with => AuthorEntity
    end

    get '/:id' do
      present Author.find(params[:id]), :with => AuthorEntity
    end

    get '/since/:date' do
      present Author.where('created_at > :date OR updated_at > :date', :date => Time.zone.parse(params[:date])), :with => AuthorEntity
    end
  end
end
