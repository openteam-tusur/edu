# encoding: utf-8
class Plan::Licence < ActiveRecord::Base
  set_table_name :plan_licences

  validates_presence_of :number, :issued_at

  belongs_to :speciality
end


# == Schema Information
#
# Table name: plan_licences
# Human name: Лицензия
#
#  id            :integer         not null, primary key
#  speciality_id :integer
#  number        :string(255)     'Номер'
#  issued_at     :date            'Дата выдачи'
#  created_at    :datetime
#  updated_at    :datetime
#

