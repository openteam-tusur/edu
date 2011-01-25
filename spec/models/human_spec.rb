# encoding: utf-8

require 'spec_helper'

describe Human do
  it "при удалении должен убивать роли" do
    human = Factory.create(:human)
    chair = Factory.create(:chair)
    human = chair.create_employee "surname" => "Фамилия",
                                  "name" => "Имя",
                                  "patronymic" => "Отчество",
                                  "post" => "старший преподаватель",
                                  "human_id" => human.id
    human.roles.should_not be_empty
    human.destroy
    Human.exists?(human.id).should be false
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
      Human.autocomplete_authors("ба").collect(&:id).sort.should eql [@bankin.id, @bapyj.id].sort
      Human.autocomplete_authors("ба жо").should eql [@bankin]
    end
  end


  describe 'должен уметь объединяться с другим человечишком' do
    before :each do
      @human1 = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
      @human2 = Human.create :name => "Ефрем", :patronymic => "Никитович", :surname => "Бапый"
    end

    after :all do
      Human.where(:id => @human2).should_not be_exists
    end

    it 'если у обоих нет аккаунтов' do
      @human1.merge_with(@human2)
    end

#    it 'если у первого есть аккаунт' do
#      user =
#      @human1.build_user(Factory.attributes_for(:user)).save!
#      @human1.reload
#      p @human1.user
#      @human1.merge_with(@human2)
#      @human1.reload
#      p @human1.user
#      @human1.reload.user.should_not be_nil
#    end

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

