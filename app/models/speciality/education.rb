# encoding: utf-8
class Speciality::Education < ActiveRecord::Base
  attr_accessor :discipline_name
  belongs_to :semester, :class_name => 'Speciality::Semester'
  belongs_to :discipline, :class_name => 'Speciality::Discipline'
  validates_presence_of :semester, :discipline

  before_validation :prepare_discipline

  private
  def prepare_discipline
    self.discipline = semester.speciality.disciplines.find_or_create_by_name(discipline_name)
  end
end
