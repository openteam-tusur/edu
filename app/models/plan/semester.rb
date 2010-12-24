# encoding: utf-8
class Plan::Semester < ActiveRecord::Base
  set_table_name :plan_semesters

  belongs_to :curriculum
  delegate :speciality, :to => :curriculum


  validates_presence_of :number, :curriculum
  validates_uniqueness_of :number, :scope => :curriculum_id

  validates_numericality_of :number, :only_integer => true

  has_many :educations, :class_name => "Plan::Education"

  default_scope :order => :number

  def to_param
    "#{self.number}"
  end

  def title
    "#{self.number} #{self.class.human_name.mb_chars.downcase.to_s}"
  end
end


# == Schema Information
#
# Table name: plan_semesters
# Human name: Семестр
#
#  id            :integer         not null, primary key
#  curriculum_id :integer
#  number        :integer         'Номер'
#  created_at    :datetime
#  updated_at    :datetime
#

