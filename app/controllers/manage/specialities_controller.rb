class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  custom_actions :resource => :transit

  belongs_to :chair, :shallow => true

  def transit
    transit! do
      @speciality.send "#{params[:event]}!" if @speciality.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to [:manage, @speciality] and return
    end
  end
end

