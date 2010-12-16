class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  belongs_to :chair, :shallow => true
end

