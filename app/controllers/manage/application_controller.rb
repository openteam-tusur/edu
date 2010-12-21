class Manage::ApplicationController < ApplicationController

  inherit_resources

  custom_actions :resource => :delete

  before_filter :verify_admin

  helper_method :cancel_url

  private

  def verify_admin
    redirect_to root_url, :alert => t( :access_denied ) unless current_user && current_user.roles.include?(:admin)
  end

  def cancel_url
    return redirect_to_url unless params[:action] == "new"
    if self.respond_to? :index
      return collection_url rescue nil
    end
    return parent_url rescue nil
    return root_url
  end

end

