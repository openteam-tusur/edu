class RolesController < ApplicationController
  load_and_authorize_resource

  belongs_to :human, :singleton => true

#  prepend_before_filter :validate_authentication

#  def create
#    raise params.inspect
#  end

  private
  def begin_of_association_chain
    current_user
  end
end

