class Manage::ApplicationController < ApplicationController
  inherit_resources
  custom_actions :resource => :delete
end
