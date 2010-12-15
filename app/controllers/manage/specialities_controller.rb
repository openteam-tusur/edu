class Manage::SpecialitiesController < Manage::ApplicationController
  inherit_resources

  belongs_to :chair, :shallow => true

  def create
    create!(:location => manage_chair_specialities_path(@chair))
  end

  def update
    update!(:location => manage_speciality_path(@chair))
  end

  def destroy
    destroy!(:location => manage_chair_specialities_path(@chair))
  end

end

