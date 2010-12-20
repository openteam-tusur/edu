#encoding: utf-8
require 'spec_helper'

describe Plan::Discipline do

  it "должно присутствовать название" do
    should validate_presence_of(:name)
  end

  it "должна присутствовать специальность" do
    should validate_presence_of(:speciality)
  end


end

# == Schema Information
#
# Table name: plan_disciplines
#
#  id            :integer         not null, primary key
#  name          :text            'Название'
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

