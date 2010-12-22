class Manage::ApplicationController < ApplicationController
  load_and_authorize_resource

  inherit_resources

  custom_actions :resource => :delete

  before_filter :verify_admin

  helper_method :cancel_url

private

  def verify_admin
    redirect_to_root_with_access_denied_message unless current_user && current_user.roles.include?(:admin)
  end

end

