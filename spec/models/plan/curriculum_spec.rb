# encoding: utf-8
require 'spec_helper'

describe Curriculum do

  it 'при создании должны создаваться семестры' do
    curriculum = Factory.create(:plan_curriculum, :semesters_count => 10)

    curriculum.semesters.count.should eql 10
  end

  it "должен находиться по слагу" do
    curriculum = Factory.create(:plan_curriculum, :semesters_count => 2)
    Curriculum.find_by_slug(curriculum.to_param).should eql curriculum
    curriculum.chair.curriculums.find_by_slug(curriculum.to_param).should eql curriculum
  end

  it 'должна правильно отдаваться продолжительность обучения в годах' do
    curriculum = Factory.create(:plan_curriculum, :semesters_count => 8)
    curriculum.duration.should eql '4 года'

    curriculum = Factory.create(:plan_curriculum, :semesters_count => 9)
    curriculum.duration.should eql '4,5 года'

    curriculum = Factory.create(:plan_curriculum, :semesters_count => 10)
    curriculum.duration.should eql '5 лет'

    curriculum = Factory.create(:plan_curriculum, :semesters_count => 11)
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
#
#  id            :integer         not null, primary key
#  study         :string(255)
#  speciality_id :integer
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)
#  year          :integer
#  access        :string(255)
#  since         :integer
#  volume        :integer
#  chair_id      :integer
#  profile       :string(255)
#

