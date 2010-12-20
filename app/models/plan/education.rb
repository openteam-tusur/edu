# encoding: utf-8
class Plan::Education < ActiveRecord::Base
  set_table_name :plan_educations

  attr_accessor :discipline_name

  belongs_to :semester
  belongs_to :discipline

  validates_presence_of :semester, :discipline
  validates_uniqueness_of :discipline_id, :scope => :semester_id

  before_validation :prepare_discipline

  def summ_loading
    summ = 0
    %w[loading_lecture
      loading_laboratory
      loading_practice
      loading_course_project
      loading_course_work
      loading_self_training].each do |field|
      summ += self.send(field) if self.send(field)
    end
    summ
  end

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

# == Schema Information
#
# Table name: plan_educations
# Human name: Дисциплина
#
#  id                     :integer         not null, primary key
#  semester_id            :integer
#  discipline_id          :integer
#  loading_lecture        :integer
#  loading_laboratory     :integer
#  loading_practice       :integer
#  loading_course_project :integer
#  loading_course_work    :integer
#  loading_self_training  :integer
#  created_at             :datetime
#  updated_at             :datetime
#

