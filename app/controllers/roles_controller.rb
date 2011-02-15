# encoding: utf-8

class RolesController < InheritedResourcesController

  check_authorization

  actions :new, :create, :edit, :update

  def create
      create! { profile_path }
  end

  def new
    redirect_to profile_path, :alert => t(:fill_human) if current_user.human.new_record?
  end

  def update
    update! { profile_path }
  end

  def edit
    redirect_to profile_path, :alert => t(:can_not_edit) unless current_user.human.roles.find(params[:id]).pending?
  end

  protected
    def begin_of_association_chain
      current_user.human
    end
end

