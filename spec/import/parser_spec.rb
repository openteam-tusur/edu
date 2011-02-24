# encoding: utf-8

require 'spec_helper'

describe Parser do
  let(:parser) { Parser.new(File.expand_path('../../data/bachelor.plm.xml', __FILE__), 'cp1251') }

  it 'должен создать специальность, если такой еще нет' do
    speciality = parser.speciality

    Speciality.count.should be 1
    speciality.name.should eql 'Бизнес-информатика'
    speciality.code.should eql '080500.62'
    speciality.degree.should eql 'bachelor'
    speciality.qualification.should eql 'Бакалавр'
  end

  it 'должен найти существующую специальность с таким же кодом' do
    speciality = Factory.create(:speciality, :code => '080500.62')

    parser.speciality.should eql speciality
  end
end

