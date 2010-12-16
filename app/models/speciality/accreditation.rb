# encoding: utf-8
class Speciality::Accreditation < ActiveRecord::Base
  validates_presence_of :number, :issued_at

  belongs_to :speciality
end


# == Schema Information
#
# Table name: speciality_accreditations
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :string(255)
#  issued_at     :date
#  created_at    :datetime
#  updated_at    :datetime
#

