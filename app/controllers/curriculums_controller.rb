class CurriculumsController < CrudController
  load_resource :class => Curriculum

  defaults :resource_class => Curriculum,
           :instance_name => :curriculum,
           :finder => :find_by_slug

  belongs_to :speciality,
             :finder => :find_by_slug

  actions :show

  def show
    show! do
      @semester = @curriculum.semesters.first
    end
  end

end

