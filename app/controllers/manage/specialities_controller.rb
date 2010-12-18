class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  custom_actions :resource => :transit

  belongs_to :chair, :shallow => true

  def new
    new! do
      @speciality.build_licence unless @speciality.licence
      @speciality.build_accreditation unless @speciality.accreditation
    end
  end

  def transit
    transit! do
      @speciality.send "#{params[:event]}!" if @speciality.aasm_events_for_current_state.include?(params[:event].to_sym)
      redirect_to [:manage, @speciality] and return
    end
  end
end

