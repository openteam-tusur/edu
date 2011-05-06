#encoding: utf-8
require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe Study do
  disconnect_sunspot

  describe "должна прозрачно работать с дисциплинами" do
    before(:each) do
      @curriculum = Factory.create(:curriculum)
      @speciality = @curriculum.speciality
      @semester = @curriculum.semesters.first
      @study = @curriculum.studies.build(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id, :cycle_id => Factory.create(:cycle).id)
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
      curriculum_2 = Factory.create(:curriculum, :speciality => @curriculum.speciality)
      @study_2 = curriculum_2.studies.build(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id, :cycle_id => Factory.create(:cycle).id)
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
# Table name: studies
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  curriculum_id :integer
#  discipline_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  cycle_id      :integer
#

