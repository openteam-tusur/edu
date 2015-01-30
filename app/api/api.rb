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
    expose(:roles,      :if => ->(a, _) { a.human }) { |a, _| a.human.try(:roles).try :map, &:post }

    expose(:created_at) { |pub, _| pub.created_at.to_i }
    expose(:updated_at) { |pub, _| pub.updated_at.to_i }
  end

  prefix :api

  rescue_from :all

  resource :publications do
    get '/' do
      present Publication.order(:id), :with => PublicationEntity
    end

    get '/kind/:kind' do
      present Publication.where(:kind => params[:kind]).order(:id), :with => PublicationEntity
    end

    get '/:id' do
      present Publication.find(params[:id]), :with => PublicationEntity
    end

    get '/since/:date' do
      present Publication.where('created_at > :date OR updated_at > :date', :date => Time.zone.parse(params[:date])), :with => PublicationEntity
    end
  end

  resource :authors do
    get '/' do
      present Author.order(:id), :with => AuthorEntity
    end

    get '/:id' do
      present Author.find(params[:id]), :with => AuthorEntity
    end

    get '/since/:date' do
      present Author.where('created_at > :date OR updated_at > :date', :date => Time.zone.parse(params[:date])), :with => AuthorEntity
    end
  end
end
