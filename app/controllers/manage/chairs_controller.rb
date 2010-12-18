class Manage::ChairsController < Manage::ApplicationController
  def index
    @faculties = Faculty.all
  end

  def show
    @chair = Chair.find(params[:id])
  end
end
