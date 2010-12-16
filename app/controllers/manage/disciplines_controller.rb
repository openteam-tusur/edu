class Manage::DisciplinesController < Manage::ApplicationController
  inherit_resources

  belongs_to :chair, :shallow => true do
    belongs_to :speciality, :shallow => true
  end

end
