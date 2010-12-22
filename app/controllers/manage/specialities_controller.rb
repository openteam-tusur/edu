class Manage::SpecialitiesController < Manage::ApplicationController
  defaults :finder => :find_by_slug
  belongs_to :chair, :finder => :find_by_slug
end

