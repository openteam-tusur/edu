# encoding: utf-8

require 'spec_helper'

describe Record do

  it { should belong_to(:issue) }

  it { should belong_to(:subject) }

  it "должна правильно определять тип записи" do
    Record.new(:fields => {"035" => "02"}).tipe.should == "Отдельный выпуск журнала"
  end

  it "должна правильно определять тематикку" do
    Record.new(:fields => {"501" => "AB01"}).main_subject_code.should == "AB"
    Record.new(:fields => {"501" => "AB01"}).subject_code.should == "AB01"
  end


  it "должен определять авторов" do
    Record.new(:fields => {"001" => "Иванов И.В."}).authors.should == "Иванов И.В."
  end

  it "должен определять ключевые слова" do
    Record.new(:fields => {"006" => "Приборостроение, микрофрезерование"}).keywords.should == "Приборостроение, микрофрезерование"
  end

  it "должен определять заголовок" do
    Record.new(:fields => {"021" => "Автоматизация проектирования и подготовки производства наукоемкой продукции в едином информационном пространстве предприятия"}).title.should == "Автоматизация проектирования и подготовки производства наукоемкой продукции в едином информационном пространстве предприятия"
  end

  it "должен определять реферат" do
    Record.new(:fields => {"100" => "Организатором семинара выступила компания „Би-Питрон”, которая занимается внедрением информационных компьютерных технологий в российской промышленности. Представлен проект CRAFT (Cooperative Research Action for Technology - совместный проект исследования для создания технологий), профинансированный ЕС, в котором важную роль сыграли продукты Cimatron. Целью проекта было развитие новых технологий и средств микрофрезерования. Необходимость работ в данной области была обусловлена тем, что сегодня все больше областей (например, микрохирургия, оптика, сенсорика, и другие) требуют применения пластмассовых деталей микроскопических раз≠ров"}).summary.should == "Организатором семинара выступила компания „Би-Питрон”, которая занимается внедрением информационных компьютерных технологий в российской промышленности. Представлен проект CRAFT (Cooperative Research Action for Technology - совместный проект исследования для создания технологий), профинансированный ЕС, в котором важную роль сыграли продукты Cimatron. Целью проекта было развитие новых технологий и средств микрофрезерования. Необходимость работ в данной области была обусловлена тем, что сегодня все больше областей (например, микрохирургия, оптика, сенсорика, и другие) требуют применения пластмассовых деталей микроскопических раз≠ров"
  end

  describe "после создания" do
    before do
      @issue = Factory :issue
      @record = @issue.reload.records.second
    end

    it "должен создавать и ассоциировать subject и main_subject" do
      @record.subject.should be_persisted
      @record.main_subject.should be_persisted
      @record.subject.title.should == "Автоматика и телемеханика"
      @record.main_subject.title.should == "Автоматика и радиоэлектроника"
    end

    it "должен относить к другим если в справочнике нет тематики" do
      @issue.records.third.subject.code.should == "ABXX"
      @issue.records.third.main_subject.code.should == "AB"
    end

    it "должен создавать и ассоциировать год и месяц" do
      @record.month.should be_persisted
      @record.year.should be_persisted
      @record.month.title.should == "01"
      @record.month.number.should == 1
      @record.year.title.should == "2007"
      @record.year.number.should == 2007
      @record.year.should == @record.month.year
    end

  end

end
