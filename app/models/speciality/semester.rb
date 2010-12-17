# encoding: utf-8
class Speciality::Semester < ActiveRecord::Base
  belongs_to :speciality

  validates_presence_of :number
  validates_uniqueness_of :number, :scope => :speciality_id

  validates_numericality_of :number, :only_integer => true

  has_many :educations

  default_scope :order => :number

end


# == Schema Information
#
# Table name: speciality_semesters
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :integer
#  created_at    :datetime
#  updated_at    :datetime
#

