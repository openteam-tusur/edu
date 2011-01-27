# encoding: utf-8
class Plan::Education < ActiveRecord::Base

  set_table_name :plan_educations

  belongs_to :semester
  belongs_to :study
  delegate :curriculum, :to => :study
  delegate :chair, :to => :study
  has_one :discipline, :through => :study
  has_and_belongs_to_many :examinations
  has_and_belongs_to_many :publication_disciplines

  attr_accessor :semester_number, :curriculum_id

  validates_presence_of :semester, :semester_number
  validates_uniqueness_of :semester_id, :scope => :study_id
  before_validation :prepare_semester

  protected_parent_of :publication_disciplines, :protects => :softly

  def title
    discipline.name
  end

  def grouped_publications
    grouped = {}
    Publication.enum(:kind).each do |kind|
      grouped[kind] = []
    end
    PublicationDiscipline.solr_search do
      with :education_ids, [self.id]
      paginate :page => 1, :per_page => 100000
    end.results.each do |publication_discipline|
      grouped[publication_discipline.publication.kind] << publication_discipline.publication
    end
    grouped
  end

  def provided_class
    PublicationDiscipline.solr_search do
      with :education_ids, [self.id]
      with :kind, ["work_programm", "tutorial"]
      facet :kind, :zeros => true
      paginate :page => 1, :per_page => 100000
    end.facet(:kind).rows.each do |facet|
      return "unprovided" if facet.count < 1
    end
    "provided"
  end

  private

    def prepare_semester
      return if self.semester_number.blank?
      old_semester = self.semester
      new_semester = Plan::Curriculum.find(self.curriculum_id || self.study.curriculum_id).semesters.find_or_create_by_number(self.semester_number)
      self.semester_id = new_semester.id
      return unless old_semester
      return if old_semester.eql?(new_semester)
      old_semester.destroy if old_semester.educations.eql? [self]
    end

end

# == Schema Information
#
# Table name: plan_educations
# Human name: Дисциплина
#
#  id          :integer         not null, primary key
#  semester_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  study_id    :integer
#

