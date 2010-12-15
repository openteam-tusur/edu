class Manage::ChairsController < Manage::ApplicationController

  def index
    @faculties = Faculty.all
  end

  def show
    @chair = Chair.find_by_slug(params[:id])
  end
end
