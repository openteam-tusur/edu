# encoding: utf-8

class Manage::ApplicationController < CrudController
  check_authorization

  layout 'backend'

  custom_actions :resource => :delete

  before_filter :verify_admin

  private
    def verify_admin
      redirect_to_root_with_access_denied_message unless current_user && current_user.roles.include?(:admin)
    end
end

