class HumansController < ApplicationController
  load_and_authorize_resource

  acts_as_singleton!

  belongs_to :user

  actions :edit, :update

end

