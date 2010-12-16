class Manage::DisciplinesController < Manage::ApplicationController
  inherit_resources

  belongs_to :chair, :shallow => true do
    belongs_to :speciality
  end

  def create
    create!(:location => parent_path(parent))
  end

  def update
    update!(:location => parent_path(parent))
  end

end
