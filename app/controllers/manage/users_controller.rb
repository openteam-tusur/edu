# encoding: utf-8

class Manage::UsersController < Manage::ApplicationController
  load_and_authorize_resource
  belongs_to :human, :singleton => true
  actions :edit, :update
  custom_actions :resource => :flush_password

  def flush_password
    flush_password! do
      @user.send_reset_password_instructions
      redirect_to parent_path and return flash[:notice] = t("devise.passwords.send_instructions_from_admin")
    end
  end

end

