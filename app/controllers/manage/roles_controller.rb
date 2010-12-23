class Manage::RolesController < Manage::ApplicationController
  load_and_authorize_resource

  belongs_to :human, :shallow => true

  defaults :instance_name => :role

  def update
    update! { parent_path }
  end
end

