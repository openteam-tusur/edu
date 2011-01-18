# encoding: utf-8

require 'spec_helper'

describe PublicationDiscipline do

  it "должен знать обучения с которыми связан" do
    curriculum = Factory.create(:plan_curriculum)
    semester = curriculum.semesters.first
    education = Factory.create(:plan_education, :semester => semester)
    publication_discipline = Factory.create(:publication_discipline, :discipline => education.discipline, :education_ids => [education.id])
    publication_discipline.educations.should eql [education]
  end

  it "должен связываться только с educations своей дисциплины, останое игнорировать" do
    curriculum = Factory.create(:plan_curriculum)
    semester = curriculum.semesters.first
    education = Factory.create(:plan_education, :semester => semester)
    other_education = Factory.create(:plan_education, :semester => semester)
    publication_discipline = Factory.create(:publication_discipline, :discipline => education.discipline, :education_ids => [education.id])
    publication_discipline.education_ids = []
    publication_discipline.save.should be false
    publication_discipline.errors[:base].empty?.should be false
  end

end


# == Schema Information
#
# Table name: publication_disciplines
#
#  id            :integer         not null, primary key
#  resource_id   :integer
#  resource_type :string(255)
#  discipline_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#

