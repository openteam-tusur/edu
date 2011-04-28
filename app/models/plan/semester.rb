# encoding: utf-8
class Semester < ActiveRecord::Base
  set_table_name :semesters

  belongs_to :curriculum
  delegate :speciality, :to => :curriculum

  validates_presence_of :number, :curriculum
  validates_uniqueness_of :number, :scope => :curriculum_id

  validates_numericality_of :number, :only_integer => true

  has_many :educations, :include => :discipline,
                        :order => 'disciplines.name',
                        :dependent => :destroy

  protected_parent_of :educations, :protects => :softly


  default_scope :order => :number

  def to_param
    "#{self.number}"
  end

  def title
    "#{self.number} #{self.class.model_name.human.mb_chars.downcase.to_s}"
  end
end



# == Schema Information
#
# Table name: plan_semesters
#
#  id            :integer         not null, primary key
#  curriculum_id :integer
#  number        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

