class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  defaults :resource_class => Speciality::Speciality,
           :instance_name  => 'speciality_speciality'
  
  belongs_to :chair, :shallow => true

  def new
    @speciality_speciality = Speciality::Speciality.new
    @speciality_speciality.build_licence unless @speciality_speciality.licence
    @speciality_speciality.build_accreditation unless @speciality_speciality.accreditation
  end
end

