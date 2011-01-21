class Manage::UsersController < Manage::ApplicationController
  load_and_authorize_resource
  def update
    update! { redirect_to manage_human_path(@user.human) and return}
  end
end
