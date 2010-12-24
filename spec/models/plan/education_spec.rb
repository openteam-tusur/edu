#encoding: utf-8
require 'spec_helper'

describe Plan::Education do

  it "должна считать суммарную нагрузку" do
    curriculum = Factory.create(:plan_curriculum)
    education = curriculum.semesters.first.educations.create!(:discipline_name => "Математика",
          :loading_lecture => 20,
          :loading_laboratory => 40,
          :loading_practice => 4,
          :loading_course_project => 12,
          :loading_course_work => 2,
          :loading_self_training => 80,
          :chair => Factory.create(:chair))
    education.summ_loading.should be 158
  end

  describe "должна прозрачно работать с дисциплинами" do
    before(:each) do
      @curriculum = Factory.create(:plan_curriculum)
      @speciality = @curriculum.speciality
      @semester = @curriculum.semesters.first
      @education = @semester.educations.build(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id)
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
      @education_2 = @curriculum.semesters.last.educations.build(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id)
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

# == Schema Information
#
# Table name: plan_educations
# Human name: Дисциплина
#
#  id                     :integer         not null, primary key
#  semester_id            :integer
#  discipline_id          :integer
#  loading_lecture        :integer         'Лекции'
#  loading_laboratory     :integer         'Лабораторные занятия'
#  loading_practice       :integer         'Практические занятия'
#  loading_course_project :integer         'Курсовое проектирование'
#  loading_course_work    :integer         'Курсовая работа'
#  loading_self_training  :integer         'Самостоятельная работа'
#  created_at             :datetime
#  updated_at             :datetime
#

