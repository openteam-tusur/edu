class ChairsController < ApplicationController

  load_and_authorize_resource

  defaults :finder => :find_by_slug
  actions :show

  def index
    @faculties = Faculty.all
  end
end

