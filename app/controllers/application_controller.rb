class ApplicationController < ActionController::Base

  protect_from_forgery

  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to :back
  end

end

