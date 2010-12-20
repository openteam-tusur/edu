class Manage::SpecialitiesController < Manage::ApplicationController
  belongs_to :chair, :finder => :find_by_slug, :shallow => true
end

