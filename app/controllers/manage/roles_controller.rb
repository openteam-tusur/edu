class Manage::RolesController < Manage::ApplicationController
  load_and_authorize_resource

  belongs_to :human, :shallow => true

  custom_actions :resource => :transit

  defaults :instance_name => :role

  def update
    update! { parent_path }
  end

  def transit
    transit! do
      @role.send "#{params[:event]}!" if @role.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to manage_human_path(@human) and return
    end
  end

end

