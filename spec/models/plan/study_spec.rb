#encoding: utf-8
require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe Plan::Study do
  disconnect_sunspot

  describe "должна прозрачно работать с дисциплинами" do
    before(:each) do
      @curriculum = Factory.create(:plan_curriculum)
      @speciality = @curriculum.speciality
      @semester = @curriculum.semesters.first
      @study = @curriculum.studies.build(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id, :cycle => 'special')
      @study.save!
    end

    it "при создании должен создавать или проставлять существующую дисциплину" do
      @study.reload.discipline.name.should eql "Математика"
      @speciality.disciplines.where(:name => "Математика").count.should be 1
    end

    it "при обновлении, если не изменяется название дисциплины, ничего не должно измениться" do
      @study.discipline_name = "Математика"
      @study.save!
      @study.reload.discipline.name.should eql "Математика"
      @speciality.disciplines.where(:name => "Математика").count.should be 1
    end

    it "при обновлении, если изменяется название дисциплины и у старой дисциплины больше ничего нет" do
      @study.discipline_name = "Физика"
      @study.save!
      @study.reload.discipline.name.should eql "Физика"
      @speciality.disciplines.where(:name => "Физика").count.should be 1
      @speciality.reload.disciplines.count.should be 1
    end

    it "при обновлении, если изменяется название дисциплины и у старой дисциплины есть еще обучения" do
      curriculum_2 = Factory.create(:plan_curriculum, :speciality => @curriculum.speciality)
      @study_2 = curriculum_2.studies.build(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id, :cycle => 'gpo')
      @study_2.save!
      @study.discipline_name = "Физика"
      @study.save!
      @study.reload.discipline.name.should eql "Физика"
      @speciality.disciplines.where(:name => "Физика").count.should be 1
      @speciality.disciplines.where(:name => "Математика").count.should be 1
      @speciality.reload.disciplines.count.should be 2
    end
  end


end


# == Schema Information
#
# Table name: plan_studies
#
#  id            :integer         not null, primary key
#  chair_id      :integer         'Кафедра'
#  curriculum_id :integer
#  discipline_id :integer         'Дисциплина'
#  created_at    :datetime
#  updated_at    :datetime
#  cycle         :string(255)     'Цикл'
#
