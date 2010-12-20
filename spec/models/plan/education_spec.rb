#encoding: utf-8
require 'spec_helper'

describe Plan::Education do

  it "должна считать суммарную нагрузку" do
    speciality = Factory.create(:speciality)
    education = speciality.semesters.first.educations.create!(:discipline_name => "Математика",
          :loading_lecture => 20,
          :loading_laboratory => 40,
          :loading_practice => 4,
          :loading_course_project => 12,
          :loading_course_work => 2,
          :loading_self_training => 80)
    education.summ_loading.should be 158
  end

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
      @education_2 = @speciality.semesters.last.educations.build(:discipline_name => "Математика")
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
