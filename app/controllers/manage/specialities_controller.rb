class Manage::SpecialitiesController < Manage::ApplicationController
  load_and_authorize_resource

  defaults :finder => :find_by_slug

  actions :all, :except => [:show]
end

