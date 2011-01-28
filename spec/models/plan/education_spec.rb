#encoding: utf-8
require 'spec_helper'
require 'sunspot/rails/spec_helper'

describe Plan::Education do
  disconnect_sunspot

  describe "должна прозрачно работать с семестрами" do
    before(:each) do
      @curriculum = Factory.create (:plan_curriculum)
      @study = @curriculum.studies.create!(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id, :cycle => 'gpo')
      @study.educations.create! :semester_number => 1
      @curriculum.reload
    end

    it "при создании должен создавать или проставлять существующий семестр" do
      @curriculum.semesters.count.should eql 1
      @curriculum.semesters.first.number.should eql 1
    end

    it "при обновлении, если не изменяется номер семестра, ничего не должно измениться" do
      @study.educations.first.update_attributes(:semester_number => 1)
      @curriculum.reload
      @curriculum.semesters.count.should eql 1
      @curriculum.semesters.first.number.should eql 1
    end

    it "при обновлении, если изменяется номер семестра и у старого семестра больше ничего нет" do
      @study.educations.first.update_attributes(:semester_number => 2)
      @curriculum.reload
      @curriculum.semesters.count.should eql 1
      @curriculum.semesters.first.number.should eql 2
    end

    it "при обновлении, если изменяется номер семестра и у старого семестра есть еще education" do
      education_2 = @study.educations.create! :semester_number => 2
      education_2.update_attributes(:semester_number => 3)
      @curriculum.reload
      @curriculum.semesters.count.should eql 2
      @curriculum.semesters.first.number.should eql 1
      @curriculum.semesters.last.number.should eql 3
    end
  end

end


# == Schema Information
#
# Table name: plan_educations
# Human name: Дисциплина
#
#  id          :integer         not null, primary key
#  semester_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  study_id    :integer
#

