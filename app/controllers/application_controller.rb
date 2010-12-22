class ApplicationController < ActionController::Base
  inherit_resources

  protect_from_forgery

  check_authorization

  helper_method :cancel_url

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    redirect_to :back
  end

  private

    def cancel_url
      return redirect_to_url unless params[:action] == "new"
      if self.respond_to? :index
        return collection_url rescue nil
      end
      return parent_url rescue nil
      return root_url
    end

end

