class RolesController < ApplicationController
  protected
    def begin_of_association_chain
      current_user.human
    end
end

