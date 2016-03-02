class Api < Grape::API
  class PublicationEntity < Grape::Entity
    expose :id
    expose :title
    expose :extended_kind
    expose :kind
    expose :volume
    expose :year
    expose :isbn
    expose :bbk
    expose :udk
    expose :stamp
    expose :annotation
    expose :content
    expose :comment
    expose(:chair_abbr) { |pub, _| pub.chair.abbr }
    expose(:download_link) { |pub, _| pub.attachment.data.url }

    expose(:author_ids) { |pub, _| pub.human_ids }
    expose(:created_at) { |pub, _| pub.created_at.to_i }
    expose(:updated_at) { |pub, _| pub.updated_at.to_i }
  end

  class HumanEntity < Grape::Entity
    expose :id
    expose :surname
    expose :name
    expose :patronymic

    expose(:roles) { |h, _| h.roles.map(&:title).uniq }
    expose(:created_at) { |pub, _| pub.created_at.to_i }
    expose(:updated_at) { |pub, _| pub.updated_at.to_i }
  end

  prefix :api

  rescue_from :all

  helpers do
    def publications_basic
      Publication.unscoped.order(:id)
    end

    def humans_basic
      Human.unscoped.joins(:publications).select('DISTINCT humans.*').order('humans.id')
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
      present humans_basic, :with => HumanEntity
    end

    get '/:id' do
      present Human.find(params[:id]), :with => HumanEntity
    end

    get '/since/:date' do
      present humans_basic.where('humans.created_at > :date OR humans.updated_at > :date', :date => Time.zone.parse(params[:date])), :with => HumanEntity
    end
  end
end
