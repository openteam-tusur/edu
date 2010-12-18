class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  belongs_to :chair, :shallow => true

  def new
    new! do
      @speciality.build_licence unless @speciality.licence
      @speciality.build_accreditation unless @speciality.accreditation
    end
  end

  def publish
    @speciality = Speciality.find(params[:id])
    @speciality.publish! if @speciality.aasm_events_for_current_state.include?(:publish)
    redirect_to [:manage, @speciality]
  end

  def unpublish
    @speciality = Speciality.find(params[:id])
    @speciality.unpublish! if  @speciality.aasm_events_for_current_state.include?(:unpublish)
    redirect_to [:manage, @speciality]
  end
end

