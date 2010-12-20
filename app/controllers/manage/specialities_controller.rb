class Manage::SpecialitiesController < Manage::ApplicationController
  belongs_to :chair, :shallow => true
end

