# encoding: utf-8

require 'spec_helper'

describe Roles::Student do
  it 'роль не должна создаваться если существует такая же роль со статусом pending' do
    role = Factory.create(:roles_student)

    new_role = Roles::Student.new(Factory(:roles_student))

    new_role.save.should be false
    new_role.errors[:base].size.should be 1
    new_role.errors[:base].first.should eql 'Ваша заявка находится на рассмотрении'
  end

  it 'роль не должна создаваться если существует такая же роль со статусом accepted' do
    role = Factory.create(:roles_student, :state => 'accepted')

    new_role = Roles::Student.new(Factory(:roles_student))

    new_role.save.should be false
    new_role.errors[:base].size.should be 1
    new_role.errors[:base].first.should eql 'Вы уже студент этой группы'
  end

end

