# encoding: utf-8

class HumansController < CrudController
  check_authorization

  load_resource :except => [:create, :show]
  authorize_resource

  prepend_before_filter :validate_authentication, :except => [:index, :show]

  acts_as_singleton!

  actions :all, :except => [:delete, :destroy]

  def index
    search = Human.search(params[:query], params)

    @humans = search.results
    @chair_facets = search.facet(:chair_ids).rows
    @role_facets = search.facet(:role_slugs).rows
  end

  def show
    if params[:id]
      @human = Human.find(params[:id])
      render :file => "humans/_view.html.erb", :layout => true
    else
      @human = current_user.human if current_user
      render :file => "humans/_profile.html.erb", :layout => true
    end
  end

  def create
    if current_user.human
      update! { profile_path }
    else
      create! {profile _path }
    end
  end

  def update
    update! { profile_path }
  end

  protected

    def begin_of_association_chain
      current_user
    end

    def validate_authentication
      redirect_to_root_with_access_denied_message unless current_user
    end

end

