# encoding: utf-8
class Chair < ActiveRecord::Base

  belongs_to :faculty

  has_many :curriculums, :class_name => "Plan::Curriculum"
  has_many :specialities, :through => :curriculums
  has_many :disciplines, :through => :specialities
  has_many :educations, :class_name => "Plan::Education"
  has_many :studies, :class_name => "Plan::Study"
  has_many :provided_disciplines, :class_name => "Plan::Discipline", :through => :educations, :source => :discipline

  validates_presence_of :name, :abbr, :slug
  validates_uniqueness_of :slug, :abbr, :name

  has_many  :accepted_roles_employees, :class_name => 'Roles::Employee',
            :conditions => {:state => "accepted"}
  has_many  :employees, :class_name => "Human", :through => :accepted_roles_employees,
            :source => :human

  has_many :publications

  default_scope order("id")

  def to_param
    self.slug
  end

  def self_with_abbr
    "#{self.name} (#{self.abbr})"
  end

  def display_name
    "#{self.abbr} - #{self.name}"
  end

  def grouped_specialities
    grouped = {}
    specialities.each do |speciality|
      grouped[speciality.degree] ||= {}
      grouped[speciality.degree][speciality] = speciality.curriculums.where(:chair_id => self)
    end
    grouped
  end

  def create_employee(params)
    human = Human.new(params.merge(:chair_id => self.id))
    return human unless human.valid?
    if existed_human = Human.find_by_id(human.human_id)
      if existed_human.accepted_employee_in_chair(self)
        human.errors[:base] << "Этот сотрудник уже есть на кафедре"
        return human
      end
      teacher = existed_human.employees.create!(:post => human.post, :chair_id => self.id)
      teacher.accept!
      return existed_human
    else
      if human.save
        teacher = human.employees.create!(:post => human.post, :chair_id => self.id)
        teacher.accept!
      end
    end
    human
  end

  def find_employee(human_id)
    employee = Human.find(human_id)
    employee_role = employee.accepted_employee_in_chair(self)
    raise ActiveRecord::RecordNotFound unless employee_role
    employee.post = employee_role.post
    employee.chair_id = self.id
    employee
  end

  def update_employee(human_id, params)
    employee = find_employee(human_id)
    employee.accepted_employee_in_chair(self).update_attribute(:post, params["post"]) if employee.update_attributes(params)
    employee
  end

  def provided_specialities
    Speciality.where(:id => provided_curriculums)
  end

  def provided_curriculums
    Plan::Curriculum.where(:id => studies.map(&:curriculum_id))
  end

  def grouped_provided_specialities
    grouped = {}
    provided_specialities.each do |speciality|
      grouped[speciality.degree] ||= []
      grouped[speciality.degree] << speciality
    end
    grouped
  end

  def grouped_curriculums_for_speciality(speciality)
    grouped = {}
    provided_curriculums.where(:speciality_id => speciality).each do |curriculum|
      grouped[curriculum] = provided_educations_for_curriculum(curriculum).count
    end
    grouped
  end

  def provided_educations_for_curriculum(curriculum)
    curriculum.educations.where(:study_id => studies)
  end

  def grouped_provided_educations_for_curriculum(curriculum)
    grouped = {}
    educations.where(:semester_id => curriculum.semesters).includes(:discipline).order("plan_disciplines.name").includes(:semester).order("plan_semesters.number").each do |education|
      grouped[education.discipline] ||= []
      grouped[education.discipline] << education
    end
    grouped
  end

  Publication.enum(:kind).each do |kind|
    class_eval <<-END
      def provided_curriculum_by_#{kind}(curriculum)
        educations_for_curriculum = provided_educations_for_curriculum(curriculum)
        publication_disciplines = PublicationDiscipline.solr_search do
          with :kind, "#{kind}"
          with :education_ids, educations_for_curriculum.map(&:id)
          paginate :page => 1, :per_page => 100000
        end.results.delete_if {|publication_discipline| publication_discipline.publication.unpublished?}
        provided_educations = publication_disciplines.map(&:educations).flatten & educations_for_curriculum
        res = {:educations => educations_for_curriculum.count,
          :provided => provided_educations.size,
          :class => educations_for_curriculum.count == provided_educations.size ? "provided" : "unprovided"}
      end
    END
  end

end

# == Schema Information
#
# Table name: chairs
# Human name: Кафедра
#
#  id         :integer         not null, primary key
#  faculty_id :integer
#  name       :string(255)     'Название'
#  abbr       :string(255)     'Аббревиатура'
#  slug       :string(255)     'Слаг'
#  created_at :datetime
#  updated_at :datetime
#

