class CurriculumsController < InheritedResources::Base
  defaults :resource_class => Plan::Curriculum,
           :instance_name => :curriculum,
           :finder => :find_by_slug

  actions :index, :show

  belongs_to :chair, :finder => :find_by_slug do
    belongs_to :speciality, :finder => :find_by_slug
  end

  def show
    show! do
      @semester = @curriculum.semesters.first
    end
  end
end

