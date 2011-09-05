# encoding: utf-8

require 'spec_helper'

describe Abstracts::Parser do

  let(:first) { Abstracts::Parser.new(Rails.root.join("spec/abstracts_data/ab01012007.iso")) }
  let(:second) { Abstracts::Parser.new(Rails.root.join("spec/abstracts_data/el022007.iso")) }

  it 'должен возвращать тематику' do
    first.topic_code.should eql 'ab01'
    first.topic.should eql 'Автоматика и вычислительная техника'
    second.topic_code.should eql 'el00'
    second.topic.should eql 'Электротехника'
  end

  it 'должен возвращать номер' do
    first.number.should eql '01'
    second.number.should eql '02'
  end

  it 'должен возвращать год' do
    first.year.should eql '2007'
    second.year.should eql '2007'
  end

  describe "данные записей" do

    def records; first.records end

    it 'должен считывать все записи' do
      records.size.should == 3
    end

    it "заголовок" do
      records.first.title.should == "Междунар. новости мира пластмасс"
      records.last.title.should == "Оптимизация и экспериментальное исследование космических конструкций из функционально гибридных материалов"
    end

    it "автор" do
      records.first.authors.should == "Никитенко Е. А."
      records.last.authors.should == "Baier H., Datashvili L., Müller U."
    end

  #  it "должно существовать поле description" do
  #    records.first.fields['xxx'].should not be nil
  #  end

   # it "поле со знаком ~%" do
  #    records.first.fields['xxx'].should ~= /≠/
  #  end

  end


end

