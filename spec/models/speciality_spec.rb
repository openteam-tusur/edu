# encoding: utf-8

require 'spec_helper'

describe 'Специальность' do

  it "должна находиться по слагу" do
    speciality = Factory.create(:speciality)
    Speciality.find_by_slug(speciality.to_param).should eql speciality
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
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)     'Код'
#

