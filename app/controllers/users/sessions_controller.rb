class Users::SessionsController < Devise::SessionsController
  authorize_resource :only => [:new, :create, :destroy], :class => User

#  before_filter :check_permissions, :only => [:new, :create, :destroy]

#  def check_permissions
#    p resource
#    authorize! :create, resource
#  end
end

