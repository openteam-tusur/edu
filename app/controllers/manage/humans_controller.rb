class Manage::HumansController < Manage::ApplicationController
  load_and_authorize_resource
  belongs_to :chair, :finder => :find_by_slug
end
