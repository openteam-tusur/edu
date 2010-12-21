# encoding: utf-8

class Speciality < ActiveRecord::Base
  validates_presence_of :chair, :code, :degree, :name, :qualification

  belongs_to  :chair

  has_many :disciplines, :class_name => "Plan::Discipline"
  has_many :curriculums, :class_name => "Plan::Curriculum"

  has_one :licence, :class_name => "Plan::Licence"
  accepts_nested_attributes_for :licence, :reject_if => :all_blank

  has_one :accreditation, :class_name => "Plan::Accreditation"
  accepts_nested_attributes_for :accreditation, :reject_if => :all_blank


  has_enum :degree, %w[specialist master bachelor]

  def slug
    "#{self.code}-#{self.degree}"
  end

  def to_param
    slug
  end

  def self.find_by_slug(slug)
    self.find_by_code_and_degree(*slug.split("-"))
  end


end


# == Schema Information
#
# Table name: specialities
# Human name: Специальность
#
#  id            :integer         not null, primary key
#  name          :string(255)     'Название'
#  degree        :string(255)
#  qualification :string(255)
#  chair_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)
#

