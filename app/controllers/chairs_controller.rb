class ChairsController < InheritedResourcesController
  defaults :finder => :find_by_slug

  actions :index, :show

  def index
    @faculties = Faculty.all
  end
end

