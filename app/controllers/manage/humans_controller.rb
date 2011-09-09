# encoding: utf-8

class Manage::HumansController < Manage::ApplicationController
  load_resource :except => [:check]
  authorize_resource

  def index
    search = Human.search(params[:query], params)

    @humans = search.results
    @chair_facets = search.facet(:chair_ids).rows
    @role_facets = search.facet(:role_slugs).rows
    @pending_role_facets = search.facet(:pending_role_slugs).rows
  end

  def check
    @humans = Human.where( :surname => params[:surname],
                           :name => params[:name],
                           :patronymic => params[:patronymic] )

    render :layout => false
  end

  def merge_with
    namesake = Human.find(params[:namesake_id])
    @human.merge_with(namesake)
    redirect_to resource_path(@human) and return flash[:notice] = t("human.merge_complete")
  end

end

