class Users::RegistrationsController < Devise::RegistrationsController
  authorize_resource :only => [:new, :create], :class => User

#  before_filter :check_permissions, :only => [:new, :create, :cancel]

#  def check_permissions
#    p resource
#    authorize! :create, resource
#  end
end

