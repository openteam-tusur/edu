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
      records.first.short_title.should == "Междунар. новости мира пластмасс"
      records.last.short_title.should == "Оптимизация и экспериментальное исследование космических конструкций из функционально гибридных материалов"
    end

    it "автор" do
      records.first.authors.should == "Никитенко Е. А."
      records.last.authors.should == "Baier H., Datashvili L., Müller U."
    end

    it "язык" do
      records.first.language.should == "Рус."
    end

    it "отражение реферативными службами" do
      records.first.reflection_abstracts_service.should == "07.01-01А.1"
    end

    pending "ключевое слово" do
      records.first.keyword.should == "Приборостроение, микрофрезерование"
    end

    it "дата издания депонирования" do
      records.first.publication_date.should == "2005"
    end

    it "основное заглавие" do
      records.first.title.should == "Автоматизация проектирования и подготовки производства наукоемкой продукции в едином информационном пространстве предприятия"
    end

    it "вид документа (двухсимвольный)" do
      records.first.view_document.should == "01"
    end

    it "код рубрики рубрикатора ВИНИТИ" do
      records.first.code_column_VINITI.should == "501.01.13"
    end

    it "место издания (страна)" do
      records.first.country.should == "RU"
    end

    it "объем, пагинация" do
      records.first.pagination.should == "с. 56, 58"
    end

    pending "номер выпуска сериального издания" do
      records.first.serial_number.should == "№ 9-10"
    end

    it "реферат" do
      records.first.summary.should == "Организатором семинара выступила компания _5Би-Питрон_6, которая занимается внедрением информационных компьютерных технологий в российской промышленности. Представлен проект CRAFT (Cooperative Research Action for Technology - совместный проект исследования для создания технологий), профинансированный ЕС, в котором важную роль сыграли продукты Cimatron. Целью проекта было развитие новых технологий и средств микрофрезерования. Необходимость работ в данной области была обусловлена тем, что сегодня все больше областей (например, микрохирургия, оптика, сенсорика, и другие) требуют применения пластмассовых деталей микроскопических раз~%ров"
    end

    it "имя (шифр) выпуска базы данных ВИНИТИ" do
      records.first.code_database.should == "AB01"
    end

    it "коды рубрики рубрикатора ГРНТИ" do
      records.first.codes_colomn_SRSTI.should == "50.01.13"
    end

    it "номер выпуска РЖ и БД" do
      records.first.number_AJ_DB.should == "01"
    end

    it "имя (шифр) тематического фрагмента БД ВИНИТИ" do
      records.first.code_thematic.should == "AB2007-ВИНИТИ"
    end

   # it "поле со знаком ~%" do
   #   records.first.fields['xxx'].should ~= /≠/
   # end

  end


end

