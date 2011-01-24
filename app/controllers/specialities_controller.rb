class SpecialitiesController < InheritedResources::Base
  defaults :finder => :find_by_slug
  belongs_to :chair, :finder => :find_by_slug
  actions :index, :show
end

