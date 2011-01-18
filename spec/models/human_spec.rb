# encoding: utf-8

require 'spec_helper'

describe Human do
  it 'должен правильно определять заполненность' do
    human = Factory.create(:human)
    human.filled?.should be false

    human.update_attributes(:surname => 'surname')
    human.reload.filled?.should be false

    human.update_attributes(:name => 'name')
    human.reload.filled?.should be false

    human.update_attributes(:patronymic => 'patronymic')
    human.reload.filled?.should be true
  end

  it "при удалении должен убивать пользователя и роли" do
    user = Factory.create(:user)
    chair = Factory.create(:chair)
    human = chair.create_employee "surname" => "Фамилия",
                                  "name" => "Имя",
                                  "patronymic" => "Отчество",
                                  "post" => "старший преподаватель",
                                  "human_id" => user.human.id
    human.destroy
    Human.exists?(human.id).should be true
    User.exists?(user.id).should be true
    Role.where(:human_id => human.id).should be_empty
  end

  it "должен знать свои рабочие программы" do
    publication = Factory.create(:publication)
    human = Factory.create(:human)
    publication.authors.create!(:human_id => human.id)

    human.publications.should eql [publication]
  end

  it "должен работать поиск сотрудников кафедры" do
    chair = Factory.create(:chair)
    human = chair.create_employee("surname" => "Фамилия",
                                  "name" => "Имя",
                                  "patronymic" => "Отчество",
                                  "post" => "старший преподаватель",
                                  "human_id" => 0)

    Human.find_accepted_employees_in_chair("", 1, chair).should eql [human]
    Human.find_accepted_employees_in_chair("Фамилия", 1, chair).should eql [human]
  end


  describe 'должен формировать список доступных авторов' do

    before(:each) do
      @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
      @bankin.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                           :post => 'Старший преподаватель')

      @bapyj = Human.create :name => "Ефрем", :patronymic => "Никитович", :surname => "Бапый"
      @bapyj.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                          :post => 'Зав. кафедрой')

      @han = Human.create :name => "Урмас",
                          :patronymic => "Йорикович",
                          :surname => "Хан"

    end

    it 'должен корректно формироваться список сотрудников, доступных в качестве авторов' do
      Human.available_authors("ба").collect(&:id).sort.should eql [@bankin.id, @bapyj.id].sort
      Human.available_authors("ба", :without => @bankin).should eql [@bapyj]
      Human.available_authors("ба жо").should eql [@bankin]
    end

  end

end

# == Schema Information
#
# Table name: humans
# Human name: Персональная информация
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  surname    :string(255)     'Фамилия'
#  name       :string(255)     'Имя'
#  patronymic :string(255)     'Отчество'
#  created_at :datetime
#  updated_at :datetime
#

