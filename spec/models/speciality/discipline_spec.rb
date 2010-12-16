#encoding: utf-8
require 'spec_helper'

describe Speciality::Discipline do

  it "должно присутствовать название" do
    should validate_presence_of(:name)
  end

  it "должна присутствовать специальность" do
    should validate_presence_of(:speciality)
  end


end
