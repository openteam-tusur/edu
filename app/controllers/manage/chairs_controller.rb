# encoding: utf-8

class Manage::ChairsController < Manage::ApplicationController

  load_and_authorize_resource

  inherit_resources
  defaults :finder => :find_by_slug
  actions :index, :show

  def index
    @faculties = Faculty.all
  end

end

