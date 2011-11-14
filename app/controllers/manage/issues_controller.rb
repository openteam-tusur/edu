class Manage::IssuesController < Manage::ApplicationController
  load_and_authorize_resource
  belongs_to :disk
  actions :all, :except => [:show]
end

