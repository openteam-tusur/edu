class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  belongs_to :chair, :finder => :find_by_slug

end

