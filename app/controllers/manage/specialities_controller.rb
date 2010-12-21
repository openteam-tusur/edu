class Manage::SpecialitiesController < Manage::ApplicationController

  load_and_authorize_resource

  defaults :finder => :find_by_slug
  belongs_to :chair, :finder => :find_by_slug
end

