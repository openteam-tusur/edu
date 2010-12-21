class Manage::ApplicationController < ApplicationController

  inherit_resources

  custom_actions :resource => :delete

  before_filter :verify_admin

  private
  def verify_admin
    redirect_to root_url unless current_user && current_user.roles.include?(:admin)
  end

end

