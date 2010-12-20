# encoding: utf-8
class Plan::Discipline < ActiveRecord::Base
  set_table_name :plan_disciplines

  belongs_to :speciality
  validates_presence_of :name, :speciality
  validates_uniqueness_of :name, :scope => :speciality_id
  has_many :educations
end

# == Schema Information
#
# Table name: plan_disciplines
#
#  id            :integer         not null, primary key
#  name          :text            'Название'
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

