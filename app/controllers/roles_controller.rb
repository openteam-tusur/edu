# encoding: utf-8

class RolesController < InheritedResourcesController

  check_authorization

  actions :all, :except => [:index, :show]

  def create
      create! { human_path }
  end

  def new
    redirect_to human_path, :alert => t(:fill_human) unless current_user.human.filled?
  end

  def update
    update! { human_path }
  end

  def edit
    redirect_to human_path, :alert => t(:can_not_edit) unless current_user.human.roles.find(params[:id]).pending?
  end

  protected
    def begin_of_association_chain
      current_user.human
    end
end

