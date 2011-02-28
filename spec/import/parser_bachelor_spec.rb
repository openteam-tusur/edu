# encoding: utf-8

require 'spec_helper'

describe Parser do
  let(:parser) { Parser.new(File.expand_path('../../data/bachelor.plm.xml', __FILE__), 'aoi') }

  it 'должен правильно определяться slug профилирующей кафедры' do
    parser.profiled_chair_slug.should eql 'aoi'
  end

  it 'должны подготавливаться аттрибуты для специальности' do
    parser.speciality_attributes[:code].should eql '080500.62'
    parser.speciality_attributes[:degree].should eql 'bachelor'
    parser.speciality_attributes[:name].should eql 'Бизнес-информатика'
    parser.speciality_attributes[:qualification].should eql 'Бакалавр'
  end

  it 'должен  подготавливать аттрибуты для учебного план' do
    parser.curriculum_attributes[:semesters_count].should be 8
    parser.curriculum_attributes[:since].should eql '2011'
  end

  it 'должны подготавливаться атрибуты для studies и educations' do
    array = parser.attributes_for_studies_and_educations
    array.size.should be 73

    array[2][:discipline_name].should eql 'Иностранный язык'
    array[2][:cycle_code].should eql 'Б1'
    array[2][:chair_slug].should eql 'iya'
    array[2][:semesters][1].should eql ['test', 'examination']
    array[2][:semesters][2].should eql ['examination']
  end

  it 'должны подготавливаться атрибуты для практик' do
    array = parser.attributes_for_studies_and_educations

    array[71][:discipline_name].should eql 'Производственная (ознакомительная) практика'
    array[71][:cycle_code].should eql 'Б5'
    array[71][:chair_slug].should eql 'aoi'
    array[71][:semesters][4].should eql ['varied_test']
  end
end

