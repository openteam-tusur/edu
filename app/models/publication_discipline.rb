# encoding: utf-8

class PublicationDiscipline < ActiveRecord::Base

  belongs_to :publication
  belongs_to :discipline, :class_name => "Plan::Discipline"
  has_one :speciality, :through => :discipline

  has_and_belongs_to_many :educations, :class_name => "Plan::Education",
                          :include => :semester,
                          :order => 'plan_semesters.number'


  validates_presence_of :publication, :discipline
  validates_uniqueness_of :discipline_id, :scope => :publication_id

  attr_accessor :speciality_request, :speciality_id, :discipline_request

  before_validation :validate_exists_of_educations

  def educations_grouped_by_curriculums
    grouped = {}
    speciality.curriculums.each do |curriculum|
      grouped[curriculum] = curriculum.educations.where(:discipline_id => discipline.id, :id => education_ids).all
    end
    grouped
  end

private

  def validate_exists_of_educations
    ids = self.education_ids & self.discipline.education_ids
    errors[:base] << "Необходимо выбрать семестры" if ids.empty?
  end

end

# == Schema Information
#
# Table name: publication_disciplines
# Human name: Дисциплина
#
#  id             :integer         not null, primary key
#  publication_id :integer         'Материал'
#  discipline_id  :integer         'Дисциплина'
#  created_at     :datetime
#  updated_at     :datetime
#

