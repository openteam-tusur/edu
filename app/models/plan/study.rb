# encoding: utf-8
class Plan::Study < ActiveRecord::Base
  set_table_name :plan_studies

  belongs_to :chair
  belongs_to :curriculum
  has_one :speciality, :through => :curriculum
  belongs_to :discipline

  has_many :educations, :class_name => "Plan::Education"
  has_many :semesters, :through => :educations, :class_name => 'Plan::Semester'

  attr_accessor :discipline_name

  validates_presence_of :chair, :discipline_name, :curriculum, :cycle
  validates_uniqueness_of :discipline_id, :scope => :curriculum_id

  before_validation :prepare_discipline

  has_enum :cycle,
           %w( humanities mathematical professional special gpo ),
           :scopes => true

  accepts_nested_attributes_for :educations, :allow_destroy => true, :reject_if => proc { |attributes| attributes['semester_id'].blank? }

  private

    def prepare_discipline
      return if discipline_name.blank?
      old_discipline = self.discipline
      new_discipline = curriculum.speciality.disciplines.find_or_create_by_name(discipline_name)
      self.discipline_id = new_discipline.id
      return unless old_discipline
      return if old_discipline.eql?(new_discipline)
      old_discipline.destroy if old_discipline.studies.eql? [self]
    end
end


# == Schema Information
#
# Table name: plan_studies
#
#  id            :integer         not null, primary key
#  chair_id      :integer         'Кафедра'
#  curriculum_id :integer
#  discipline_id :integer         'Дисциплина'
#  created_at    :datetime
#  updated_at    :datetime
#  cycle         :string(255)     'Цикл'
#

