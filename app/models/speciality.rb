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

end


# == Schema Information
#
# Table name: specialities
# Human name: Специальность
#
#  id            :integer         not null, primary key
#  name          :string(255)     'Название'
#  degree        :string(255)     'Степень'
#  qualification :string(255)     'Квалификация'
#  chair_id      :integer
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)     'Код'
#

