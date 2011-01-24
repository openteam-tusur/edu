class Manage::RolesController < Manage::ApplicationController
  load_and_authorize_resource

  belongs_to :human, :shallow => true

  actions :all, :except => [:index, :show]

  custom_actions :resource => :transit

  defaults :instance_name => :role

  def transit
    transit! do
      @role.send "#{params[:event]}!" if @role.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to parent_url and return
    end
  end

  private

    def build_resource
      association_chain
      @human.send(params[:type].pluralize).build(params[:role])
    end
end

