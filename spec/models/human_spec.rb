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
    User.exists?(user.id).should be false
    Role.where(:human_id => human.id).empty?.should be true
  end

  it "должен знать свои рабочие программы" do
    work_programm = Factory.create(:work_programm)
    human = Factory.create(:human)
    work_programm.authors.create!(:human_id => human.id)

    human.work_programms.should eql [work_programm]
  end


  describe 'должен формировать список доступных авторов' do

    before(:each) do
      @bankin = Human.create :name => "Ерофей", :patronymic => "Жозефович", :surname => "Банькин"
      @bankin.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                           :post => 'Старший преподаватель')

      @lapyj = Human.create :name => "Ефрем", :patronymic => "Никитович", :surname => "Лапый"
      @lapyj.roles << Roles::Employee.new(:chair => Factory.create(:chair),
                                          :post => 'Зав. кафедрой')
    end

    it 'должен корректно формироваться список сотрудников, доступных в качестве авторов' do
      Human.available_authors.all.should eql [@bankin, @lapyj]
      Human.available_authors(@bankin.id).all.should eql [@lapyj]
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

