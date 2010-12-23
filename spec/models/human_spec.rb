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

