# encoding: utf-8

require 'spec_helper'

describe Roles::Student do
  it 'роль не должна создаваться если существует такая же роль со статусом pending' do
    role = Factory.create(:roles_student)

    new_role = Roles::Student.new(role.attributes.merge(:human_id => role.human.id))

    new_role.save.should be false
    new_role.errors[:base].size.should be 1
    new_role.errors[:base].first.should eql 'Ваша заявка находится на рассмотрении'
  end

  it 'роль не должна создаваться если существует такая же роль со статусом accepted' do
    role = Factory.create(:roles_student, :state => 'accepted')

    new_role = Roles::Student.new(role.attributes.merge(:human_id => role.human.id))

    new_role.save.should be false
    new_role.errors[:base].size.should be 1
    new_role.errors[:base].first.should eql 'Вы уже студент этой группы'
  end

end


# == Schema Information
#
# Table name: roles
#
#  id            :integer         not null, primary key
#  human_id      :integer
#  title         :string(255)
#  slug          :string(255)
#  type          :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  state         :string(255)
#  group         :string(255)
#  birthday      :date
#  chair_id      :integer
#  post          :string(255)
#  contingent_id :integer
#

