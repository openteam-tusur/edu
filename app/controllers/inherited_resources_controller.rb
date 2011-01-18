class InheritedResourcesController < ApplicationController
  inherit_resources

  helper_method :cancel_url

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

