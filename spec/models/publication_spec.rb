#encoding: utf-8

require 'spec_helper'

describe Publication do
  before(:each) do
    @publication = Factory.create(:publication)
  end

  it "должен быть статус unpublished" do
    @publication.state.should eql 'unpublished'
  end

  it 'кол-во рабочих опубликованных программ должно считаться правильно' do
    @publication2 = Factory.create(:publication)
    @publication3 = Factory.create(:publication)
    @publication.update_attributes(:state => 'published')
    @publication2.update_attributes(:state => 'published')
    Publication.published.count.should   eql 2
    Publication.unpublished.count.should eql 1
    Publication.count.should             eql 3
  end

  it 'должны привязываться авторы' do
    @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
    @publication.update_attributes :authors_attributes => [
      { :human =>  @bankin }
    ]

    @publication.authors.first.human.should eql @bankin
  end

  it 'должен создаваться объект из хэша' do
    @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
    @chair = Factory.create :chair
    @wp = @chair.publications.create! Factory(:publication).merge(:authors_attributes => [{:human_id => @bankin.id}])
    @wp.authors.collect(&:human).should eql [@bankin]
  end

end

# == Schema Information
#
# Table name: publications
# Human name: Учебно-методический материал
#
#  id         :integer         not null, primary key
#  chair_id   :integer
#  title      :string(255)     'Название'
#  year       :integer         'Год издания'
#  volume     :integer         'Количество страниц'
#  state      :string(255)     'Статус'
#  access     :string(255)     'Доступ к файлу'
#  kind       :string(255)     'Тип учебного материала'
#  isbn       :string(255)     'ISBN'
#  udk        :string(255)     'УДК'
#  bbk        :string(255)     'ББК'
#  stamp      :text            'Гриф'
#  created_at :datetime
#  updated_at :datetime
#  content    :text
#  annotation :text
#

