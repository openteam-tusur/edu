class HumansController < ApplicationController
  load_and_authorize_resource

  prepend_before_filter :validate_authentication

  acts_as_singleton!

  actions :edit, :update, :show

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

