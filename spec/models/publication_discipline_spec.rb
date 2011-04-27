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

  it "должна группировать educations по формам обучения учебного плана" do
    curriculum_1 = Factory.create(:plan_curriculum, :study => "fulltime")
    study_1 = Factory.create(:plan_study, :curriculum => curriculum_1)
    education_1_1 = Factory.create(:plan_education, :semester => curriculum_1.semesters.first, :study => study_1)
    education_1_2 = Factory.create(:plan_education, :semester => curriculum_1.semesters.second, :study => study_1)
    education_1_3 = Factory.create(:plan_education, :semester => curriculum_1.semesters.last, :study => study_1)

    curriculum_2 = Factory.create(:plan_curriculum, :speciality => curriculum_1.speciality, :study => "postal")
    study_2 = Factory.create(:plan_study, :curriculum => curriculum_2)
    education_2_1 = Factory.create(:plan_education, :semester => curriculum_2.semesters.first, :study => study_2)
    education_2_2 = Factory.create(:plan_education, :semester => curriculum_2.semesters.second, :study => study_2)

    curriculum_3 = Factory.create(:plan_curriculum, :speciality => curriculum_1.speciality, :study => "parttime")

    publication = Factory.create(:publication)
    publication_discipline = publication.publication_disciplines.create!(:discipline => education_1_1.discipline, :education_ids => [education_1_1.id, education_1_2.id, education_2_1.id])

    expected = {
      curriculum_1 => [education_1_1, education_1_2],
      curriculum_2 => [education_2_1]
    }

    publication_discipline.educations_grouped_by_curriculums.should eql expected
  end

end



# == Schema Information
#
# Table name: publication_disciplines
#
#  id             :integer         not null, primary key
#  publication_id :integer
#  discipline_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#

