# encoding: utf-8

class RolesController < InheritedResourcesController

  check_authorization

  actions :new, :create

  def create
      create! { profile_path }
  end

  def new
    redirect_to profile_path, :alert => t(:fill_human) if current_user.human.new_record?
  end

  protected
    def begin_of_association_chain
      current_user.human
    end
end

