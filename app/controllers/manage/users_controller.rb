class Manage::UsersController < Manage::ApplicationController
  load_and_authorize_resource
  def update
    update! { manage_human_path(@user.human) }
  end
end
