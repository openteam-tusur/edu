class CurriculumsController < InheritedResources::Base
  load_resource :class => Plan::Curriculum

  defaults :resource_class => Plan::Curriculum,
           :instance_name => :curriculum,
           :finder => :find_by_slug

  actions :index, :show

  belongs_to :chair, :finder => :find_by_slug

  actions :index, :show

  def index
    @specialities = @chair.grouped_specialities
  end

  def show
    show! do
      @semester = @curriculum.semesters.first
    end
  end
end

