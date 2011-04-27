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
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  degree        :string(255)
#  qualification :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  code          :string(255)
#

