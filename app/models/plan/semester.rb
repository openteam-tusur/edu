# encoding: utf-8
class Plan::Semester < ActiveRecord::Base
  set_table_name :plan_semesters

  belongs_to :speciality

  validates_presence_of :number, :speciality
  validates_uniqueness_of :number, :scope => :speciality_id

  validates_numericality_of :number, :only_integer => true

  has_many :educations

  default_scope :order => :number
end


# == Schema Information
#
# Table name: plan_semesters
# Human name: Семестр
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :integer         'Номер'
#  created_at    :datetime
#  updated_at    :datetime
#

