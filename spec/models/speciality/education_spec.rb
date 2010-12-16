#encoding: utf-8
require 'spec_helper'

describe Speciality::Education do

  it "при создании должен создавать или проставлять существующую дисциплину" do
    speciality = Factory.create(:speciality)
    semester = speciality.semesters.first
    education = semester.educations.build(:discipline_name => "Математика")
    education.save!
    education.reload.discipline.name.should eql "Математика"
  end

end
