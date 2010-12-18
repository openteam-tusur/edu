class Manage::SpecialitiesController < Manage::ApplicationController

  inherit_resources

  belongs_to :chair, :shallow => true

  def new
    new! do
      @speciality.build_licence unless @speciality.licence
      @speciality.build_accreditation unless @speciality.accreditation
    end
  end

end

