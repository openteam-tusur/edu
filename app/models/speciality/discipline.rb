# encoding: utf-8
class Speciality::Discipline < ActiveRecord::Base
  belongs_to :speciality
  validates_presence_of :name, :speciality
  validates_uniqueness_of :name, :scope => :speciality_id
end

# == Schema Information
#
# Table name: disciplines
# Human name: Дисциплина
#
#  id            :integer         not null, primary key
#  name          :text            'Название'
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

