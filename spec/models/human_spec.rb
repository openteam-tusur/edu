# encoding: utf-8

require 'spec_helper'

describe Human do
  it "при удалении должен убивать роли" do
    chair = Factory.create(:chair)
    human = Factory.create(:human)
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
    after :all do
      Human.where(:id => @human2).should_not be_exists
    end

    it 'если у обоих нет аккаунтов' do
      @human1 = Factory.create :human
      @human2 = Factory.create :human
      @human1.merge_with(@human2)
    end

    it 'если у первого есть аккаунт' do
      @human1 = Factory.create(:user).human
      @human2 = Factory.create :human
      @human1.merge_with(@human2)
      @human1.user.should_not be_nil
    end

    it 'если у второго есть аккаунт' do
      @human1 = Factory.create :human
      @user2 = Factory.create(:user)
      @human2 = @user2.human
      @human1.merge_with(@human2)
      @human1.user.should eql @user2
    end

    it 'если у обоих есть аккаунты' do
      @user1 = Factory.create(:user)
      @human1 = @user1.human
      @user2 = Factory.create(:user)
      @human2 = @user2.human
      @human1.merge_with(@human2)
      @human1.user.should eql @user1
      User.where(:id => @user2).should_not be_exists
    end

    describe "Роли: " do
      before :each do
        @human1 = Factory.create :human
        @human2 = Factory.create :human
      end

      it 'есть у первого' do
        @human1.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                             :post => 'Старший преподаватель')
        @human1.merge_with(@human2)
        @human1.roles.should_not be_empty
      end

      it 'есть у второго' do
        @human2.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                             :post => 'Старший преподаватель')
        @human1.merge_with(@human2)
        @human1.reload
        @human1.roles.should_not be_empty
      end

      it 'есть у обоих' do
        @human1.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                             :post => 'Старший преподаватель')

        @human2.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                             :post => 'Старший преподаватель')

        @human1.merge_with(@human2)
        @human1.roles.count.should be 2
      end

      it 'есть у обоих и они одинаковые' do
        chair = Factory.create(:chair)
        @human1.roles << Roles::Employee.new(:chair => chair,
                                             :post => 'Старший преподаватель')

        @human2.roles << Roles::Employee.new(:chair => chair,
                                             :post => 'Старший преподаватель')

        @human1.merge_with(@human2)
        @human1.roles.count.should be 1
      end

    end

    describe "Авторы: " do
      before :each do
        @human1 = Factory.create :human
        @human2 = Factory.create :human
        @publication = Factory.create :publication
        @human2.authors.create :resource => @publication
      end

      it 'авторы есть у второго' do
        @human1.merge_with(@human2)
        @human1.reload
        @human1.authors.count.should be 1
      end

      it 'авторы есть у обоих есть и они одинаковые' do
        @human1.authors.create :resource => @publication
        @human1.merge_with(@human2)
        @human1.reload
        @human1.authors.count.should be 1
      end
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

