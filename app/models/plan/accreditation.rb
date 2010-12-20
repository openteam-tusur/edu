# encoding: utf-8
class Plan::Accreditation < ActiveRecord::Base
  set_table_name :plan_accreditations
  validates_presence_of :number, :issued_at

  belongs_to :speciality
end


# == Schema Information
#
# Table name: plan_accreditations
# Human name: Свидетельство об аккредитации
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :string(255)     'Номер'
#  issued_at     :date            'Дата выдачи'
#  created_at    :datetime
#  updated_at    :datetime
#

