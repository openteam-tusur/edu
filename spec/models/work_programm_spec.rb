#encoding: utf-8

require 'spec_helper'

describe WorkProgramm do
  before(:each) do
    @work_programm = Factory.create(:work_programm)
  end

  it "должен быть статус unpublished" do
    @work_programm.state.should eql 'unpublished'
  end

  it 'кол-во рабочих опубликованных программ должно считаться правильно' do
    @work_programm2 = Factory.create(:work_programm)
    @work_programm3 = Factory.create(:work_programm)
    @work_programm.update_attributes(:state => 'published')
    @work_programm2.update_attributes(:state => 'published')
    WorkProgramm.published.count.should   eql 2
    WorkProgramm.unpublished.count.should eql 1
    WorkProgramm.count.should             eql 3
  end

  it 'должны привязываться авторы' do
    @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
    @work_programm.update_attributes :authors_attributes => [
      { :human =>  @bankin }
    ]

    @work_programm.authors.first.human.should eql @bankin
  end

  it 'должен создаваться объект из хэша' do
    @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
    @chair = Factory.create :chair
    @wp = @chair.work_programms.create! Factory(:work_programm).merge(:authors_attributes => [{:human_id => @bankin.id}])
    @wp.authors.collect(&:human).should eql [@bankin]
  end

end

# == Schema Information
#
# Table name: work_programms
# Human name: Рабочая программа
#
#  id            :integer         not null, primary key
#  chair_id      :integer
#  year          :integer         'Год издания'
#  state         :string(255)     'Статус'
#  access        :string(255)     'Доступ к файлу'
#  resource_name :text            'Название файла'
#  created_at    :datetime
#  updated_at    :datetime
#  title         :text            'Название'
#  volume        :integer         'Количество страниц'
#

