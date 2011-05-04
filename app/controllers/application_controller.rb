# encoding: utf-8

class ApplicationController < ActionController::Base
  layout 'frontend'

  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to :back, :status => 403 rescue redirect_to root_path, :status => 403
  end

  def main_page
    render :file => 'shared/main.html.erb', :layout => 'application'
  end

  protected
    def redirect_to_root_with_access_denied_message
      redirect_to root_url, :alert => t( :access_denied )
    end
end

