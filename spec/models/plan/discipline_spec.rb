#encoding: utf-8
require 'spec_helper'

describe Plan::Discipline do

  it "должно присутствовать название" do
    should validate_presence_of(:name)
  end

  it "должна присутствовать специальность" do
    should validate_presence_of(:speciality)
  end

  it "должна знать сгруппированные по форме обучения educations" do
    discipline = Factory.create(:plan_discipline)
    fulltime_curriculum = Factory.create(:plan_curriculum, :speciality => discipline.speciality)
    postal_curriculum = Factory.create(:plan_curriculum, :speciality => discipline.speciality, :study => "postal")
    Factory.create(:plan_curriculum, :speciality => discipline.speciality, :study => "parttime")
    Factory.create(:plan_education, :semester => fulltime_curriculum.semesters.first)
    study = Factory.create(:plan_study, :discipline => discipline, :curriculum => fulltime_curriculum)
    fulltime_education_first = Factory.create(:plan_education, :semester => fulltime_curriculum.semesters.first, :study => study)
    fulltime_education_last = Factory.create(:plan_education, :semester => fulltime_curriculum.semesters.last, :study => study)
    postal_education = Factory.create(:plan_education, :semester => postal_curriculum.semesters.last,
                                      :study => Factory.create(:plan_study, :discipline => discipline, :curriculum => postal_curriculum))

    expected_hash = {fulltime_curriculum => [fulltime_education_first, fulltime_education_last],
          postal_curriculum => [postal_education]}
    discipline.reload.educations_grouped_by_curriculums.should eql expected_hash
  end


end


# == Schema Information
#
# Table name: plan_disciplines
#
#  id            :integer         not null, primary key
#  name          :text
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

