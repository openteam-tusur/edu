# encoding: utf-8
class Plan::Licence < ActiveRecord::Base
  set_table_name :plan_licences

  validates_presence_of :number, :issued_at

  belongs_to :speciality
end


# == Schema Information
#
# Table name: speciality_licences
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :string(255)
#  issued_at     :date
#  created_at    :datetime
#  updated_at    :datetime
#

