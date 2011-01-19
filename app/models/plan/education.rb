# encoding: utf-8
class Plan::Education < ActiveRecord::Base

  set_table_name :plan_educations

  attr_accessor :discipline_name

  belongs_to :semester
  has_one :curriculum, :through => :semester
  belongs_to :discipline
  belongs_to :chair
  has_and_belongs_to_many :examinations
  has_and_belongs_to_many :publication_disciplines

  validates_presence_of :semester, :chair, :discipline_name
  validates_uniqueness_of :discipline_id, :scope => :semester_id

  before_validation :prepare_discipline

  protected_parent_of :publication_disciplines, :protects => :softly

  default_values :loading_lecture => 0, :loading_laboratory => 0,
                 :loading_practice => 0, :loading_course_project => 0,
                 :loading_course_work => 0, :loading_self_training => 0

  def loading_summ
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

  def title
    discipline.name
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
#  loading_lecture        :integer         'Лекции'
#  loading_laboratory     :integer         'Лабораторные занятия'
#  loading_practice       :integer         'Практические занятия'
#  loading_course_project :integer         'Курсовое проектирование'
#  loading_course_work    :integer         'Курсовая работа'
#  loading_self_training  :integer         'Самостоятельная работа'
#  created_at             :datetime
#  updated_at             :datetime
#  chair_id               :integer
#

