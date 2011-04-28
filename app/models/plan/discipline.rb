# encoding: utf-8
class Discipline < ActiveRecord::Base
  set_table_name :disciplines

  belongs_to :speciality
  validates_presence_of :name, :speciality
  validates_uniqueness_of :name, :scope => :speciality_id

  has_many :studies
  has_many :educations, :through => :studies

  default_scope order("disciplines.name")

  searchable do
    text :name
    integer :speciality_id
  end

  def educations_grouped_by_curriculums
    grouped = {}
    speciality.curriculums.where(:id => educations.map(&:curriculum)).each do |curriculum|
      grouped[curriculum] = curriculum.educations.where(:id => educations).all
    end
    grouped
  end

end


# == Schema Information
#
# Table name: disciplines
#
#  id            :integer         not null, primary key
#  name          :text
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

