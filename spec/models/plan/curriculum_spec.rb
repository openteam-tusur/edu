# encoding: utf-8
require 'spec_helper'

describe Plan::Curriculum do

  it "должен находиться по слагу" do
    curriculum = Factory.create(:plan_curriculum, :semesters_count => 2)
    Plan::Curriculum.find_by_slug(curriculum.to_param).should eql curriculum
    curriculum.chair.curriculums.find_by_slug(curriculum.to_param).should eql curriculum
  end

  it 'должна правильно отдаваться продолжительность обучения в годах' do
    curriculum = Factory.create(:plan_curriculum, :semesters_count => 8)
    study = curriculum.studies.create!(:discipline_name => "Математика", :chair_id => Factory.create(:chair).id)

    8.times do |index|
      study.educations.create! :semester_number => index + 1
    end
    curriculum.duration.should eql '4 года'

    study.educations.create! :semester_number => 9
    curriculum.duration.should eql '4,5 года'

    study.educations.create! :semester_number => 10
    curriculum.duration.should eql '5 лет'

    study.educations.create! :semester_number => 11
    curriculum.duration.should eql '5,5 лет'
  end

  it 'может публиковаться и убираться с публикации' do
    curriculum = Factory.create(:plan_curriculum)
    curriculum.unpublished?.should eql true

    curriculum.publish!
    curriculum.reload.published?.should eql true

    curriculum.unpublish!
    curriculum.reload.unpublished?.should eql true
  end

  it "должен требовать заполнения всех полей ресурса, если заполнено хоть одно" do
    curriculum = Factory.create(:plan_curriculum)
    curriculum.year = "2010"
    curriculum.save.should be false
    curriculum.errors[:attachment].should_not be nil
  end

end

# == Schema Information
#
# Table name: plan_curriculums
# Human name: Учебный план
#
#  id            :integer         not null, primary key
#  study         :string(255)     'Форма обучения'
#  speciality_id :integer         'Направление подготовки (специальность)'
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)     'Статус'
#  year          :integer         'Год издания'
#  access        :string(255)     'Доступ к файлу'
#  since         :integer         'Действует с'
#  volume        :integer         'Количество страниц'
#  chair_id      :integer
#

