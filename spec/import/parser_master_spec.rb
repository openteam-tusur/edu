# encoding: utf-8

require 'spec_helper'

describe Import::Parser do
  let(:parser) { Import::Parser.new(File.expand_path('../../data/master.plm.xml', __FILE__), 'aoi') }

  it 'должен правильно определяться slug профилирующей кафедры' do
    parser.profiled_chair_slug.should eql 'aoi'
  end

  it 'должны подготавливаться аттрибуты для специальности' do
    parser.speciality_attributes[:code].should eql '081100.68'
    parser.speciality_attributes[:degree].should eql 'master'
    parser.speciality_attributes[:name].should eql 'Государственное и муниципальное управление'
    parser.speciality_attributes[:qualification].should eql 'Магистр'
  end

  it 'должен  подготавливать аттрибуты для учебного план' do
    parser.curriculum_attributes[:semesters_count].should be 4
    parser.curriculum_attributes[:since].should eql '2011'
  end

  it 'должны подготавливаться атрибуты для studies и educations' do
    array = parser.attributes_for_studies_and_educations
    array.size.should be 32

    array[3][:discipline_name].should eql 'История и методология науки и производства: эволюция управленческой мысли и общая методология'
    array[3][:cycle_code].should eql 'М1'
    array[3][:chair_slug].should eql 'aoi'
    array[3][:semesters][3].should eql ['test']

    array[4][:discipline_name].should eql 'Современные проблемы государственного и муниципального управления'
    array[4][:cycle_code].should eql 'М1'
    array[4][:chair_slug].should eql 'aoi'
    array[4][:semesters][1].should eql ['examination']

    array[28][:discipline_name].should eql 'Научно-исследовательская работа магистра'
    array[28][:cycle_code].should eql 'М3'
    array[28][:chair_slug].should eql 'aoi'
    array[28][:semesters][1].should eql ['test']
    array[28][:semesters][2].should eql ['test']
  end

  it 'должны подготавливаться атрибуты для практик' do
    array = parser.attributes_for_studies_and_educations

    array[30][:discipline_name].should eql 'Производственная практика'
    array[30][:cycle_code].should eql 'М3'
    array[30][:chair_slug].should eql 'aoi'
    array[30][:semesters][2].should eql ['varied_test']
  end
end

