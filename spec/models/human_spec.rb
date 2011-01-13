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
    human = chair.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель",
                                    "human_id" => user.human.id)
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

