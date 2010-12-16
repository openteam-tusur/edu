# encoding: utf-8

require 'spec_helper'

describe 'Специальность' do
  it 'при создании специальности должны создаваться семестры' do
    speciality = Factory.create(:speciality, :semesters_count => 10)

    speciality.semesters.count.should eql 10
  end
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

