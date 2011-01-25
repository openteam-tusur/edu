class HumansController < InheritedResourcesController
  check_authorization

  load_resource :except => [:create]
  authorize_resource

  prepend_before_filter :validate_authentication

  acts_as_singleton!

  actions :all, :except => [:index, :delete, :destroy]

  def create
    if current_user.human
      update! { human_path }
    else
      create! { human_path }
    end
  end

  def update
    update! { human_path }
  end

  protected

    def begin_of_association_chain
      current_user
    end

    def validate_authentication
      redirect_to_root_with_access_denied_message unless current_user
    end

end

