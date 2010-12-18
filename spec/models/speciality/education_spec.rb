#encoding: utf-8
require 'spec_helper'

describe Plan::Education do

  describe "должна прозрачно работать с дисциплинами" do
    before(:each) do
      @speciality = Factory.create(:speciality)
      @semester = @speciality.semesters.first
      @education = @semester.educations.build(:discipline_name => "Математика")
      @education.save!
    end

    it "при создании должен создавать или проставлять существующую дисциплину" do
      @education.reload.discipline.name.should eql "Математика"
      @speciality.disciplines.where(:name => "Математика").count.should be 1
    end

    it "при обновлении, если не изменяется название дисциплины, ничего не должно измениться" do
      @education.discipline_name = "Математика"
      @education.save!
      @education.reload.discipline.name.should eql "Математика"
      @speciality.disciplines.where(:name => "Математика").count.should be 1
    end

    it "при обновлении, если изменяется название дисциплины и у старой дисциплины больше ничего нет" do
      @education.discipline_name = "Физика"
      @education.save!
      @education.reload.discipline.name.should eql "Физика"
      @speciality.disciplines.where(:name => "Физика").count.should be 1
      @speciality.reload.disciplines.count.should be 1
    end

    it "при обновлении, если изменяется название дисциплины и у старой дисциплины есть еще обучения" do
      @education_2 = @semester.educations.build(:discipline_name => "Математика")
      @education_2.save!
      @education.discipline_name = "Физика"
      @education.save!
      @education.reload.discipline.name.should eql "Физика"
      @speciality.disciplines.where(:name => "Физика").count.should be 1
      @speciality.disciplines.where(:name => "Математика").count.should be 1
      @speciality.reload.disciplines.count.should be 2
    end
  end

end
