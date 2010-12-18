# encoding: utf-8
class Plan::Education < ActiveRecord::Base
  set_table_name :plan_educations

  attr_accessor :discipline_name

  belongs_to :semester
  belongs_to :discipline

  validates_presence_of :semester, :discipline

  before_validation :prepare_discipline

  private
  def prepare_discipline
    return if discipline_name.blank?
    old_discipline = self.discipline
    new_discipline = semester.speciality.disciplines.find_or_create_by_name(discipline_name)
    self.discipline_id = new_discipline.id
    return unless old_discipline
    return if old_discipline.eql?(new_discipline)
    old_discipline.destroy if old_discipline.educations.eql? [self]
  end
end
