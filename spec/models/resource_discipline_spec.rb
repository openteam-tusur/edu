# encoding: utf-8

require 'spec_helper'

describe ResourceDiscipline do

  it "должен знать обучения с которыми связан" do
    curriculum = Factory.create(:plan_curriculum)
    semester = curriculum.semesters.first
    education = Factory.create(:plan_education, :semester => semester)
    resource_discipline = Factory.create(:resource_discipline, :discipline => education.discipline, :education_ids => [education.id])
    resource_discipline.educations.should eql [education]
  end

  it "должен связываться только с educations своей дисциплины, останое игнорировать" do
    curriculum = Factory.create(:plan_curriculum)
    semester = curriculum.semesters.first
    education = Factory.create(:plan_education, :semester => semester)
    other_education = Factory.create(:plan_education, :semester => semester)
    resource_discipline = Factory.create(:resource_discipline, :discipline => education.discipline, :education_ids => [education.id])
    resource_discipline.education_ids = []
    resource_discipline.save.should be false
    resource_discipline.errors[:base].empty?.should be false
  end

end


# == Schema Information
#
# Table name: resource_disciplines
#
#  id            :integer         not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  discipline_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

