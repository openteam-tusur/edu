class Manage::HumansController < Manage::ApplicationController
  load_resource :except => :check
  authorize_resource

  def check
    @humans = Human.where( :surname => params[:surname],
                           :name => params[:name],
                           :patronymic => params[:patronymic] )

    render :partial => "check", :layout => false
  end
end

