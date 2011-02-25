# encoding: utf-8

require 'spec_helper'

describe Parser do
  before(:all) do
    load_cycles
    load_examinations
  end

  let(:parser) { Parser.new(File.expand_path('../../data/bachelor.plm.xml', __FILE__), 'cp1251') }

  it 'должен подготавливать специальность, если такой еще нет' do
    parser.speciality.new_record?.should be true
    parser.speciality.name.should eql 'Бизнес-информатика'
    parser.speciality.code.should eql '080500.62'
    parser.speciality.degree.should eql 'bachelor'
    parser.speciality.qualification.should eql 'Бакалавр'
  end

  it 'должен найти существующую специальность с таким же кодом' do
    speciality = Factory.create(:speciality, :code => '080500.62')

    parser.speciality.should eql speciality
  end

  it 'должен  подготавливать план' do
    parser.curriculum.new_record?.should be true
    parser.curriculum.since.should eql 2011
  end

  it 'должен определять количество семестров для учебного плана' do
    parser.curriculum.speciality_id = Factory.create(:speciality).id
    parser.curriculum.save

    parser.curriculum.reload.semesters_count.should be 8
  end

  it 'должны подготавливаться массив из study' do
    parser.studies_with_education_attributes.size.should be 70

    cycle = Plan::Cycle.where(:degree => 'bachelor', :code => 'Б1').first

    study, hz = parser.studies_with_education_attributes.to_a[2]

    study.discipline_name.should eql 'Иностранный язык'
    study.cycle_id.should eql cycle.id

    hz['1'].should eql [Examination.find_by_slug('test'), Examination.find_by_slug('examination')]
    hz['2'].should eql [Examination.find_by_slug('examination')]
  end
end

