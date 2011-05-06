# encoding: utf-8

require 'spec_helper'

describe Import::Importer do
  let(:importer) { Import::Importer.new(File.expand_path('../../data/bachelor.plm.xml', __FILE__), 'aoi') }

  before(:each) do
    load_cycles
    load_examinations
    load_chairs
  end

  it 'должен создавать новую специальность' do
    importer.import

    Speciality.count.should be 1
    Speciality.first.code.should eql '080500.62'
    Speciality.first.degree.should eql 'bachelor'
    Speciality.first.name.should eql 'Бизнес-информатика'
    Speciality.first.qualification.should eql 'Бакалавр'

  end

  it 'должен находить существующую специальность' do
    Factory.create(:speciality, :code => '080500.62')
    importer.import

    Speciality.count.should be 1
  end

  it 'должен создавать учебный план' do
    importer.import

    Curriculum.first.speciality.should eql Speciality.first
    Curriculum.first.chair.should eql Chair.find_by_slug('aoi')
  end

  describe 'при повторном импорте для существующего учебного плана' do
    it 'должен создавать дисциплины, которых раньше не было' do
      importer.import
    end
  end
end

