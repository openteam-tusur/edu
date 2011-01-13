# encoding: utf-8

require 'spec_helper'

describe Chair do

  describe "при работе с сотрудниками" do
    before(:each) do
      @chair = Factory.create(:chair)
      @employee = @chair.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель",
                                    "human_id" => 0)
    end

    it "должна уметь создавать сотрудника" do
      @employee.new_record?.should be false
      role = @employee.employees.first
      role.accepted?.should be true
      role.chair.should eql @chair
    end

    it "должна быть ошибка если не указана должность" do
      employee = @chair.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество")
      employee.errors[:post].should_not be nil
    end

    it "должна знать сотрудников" do
      expired_employee_chair = @chair.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель",
                                    "human_id" => 0)
      expired_employee_chair.employees.first.expire!
      chair_2 = Factory.create(:chair)
      employee_chair_2 = chair_2.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель",
                                    "human_id" => 0)
      @chair.employees.all.should eql [@employee]
    end

    it "должна уметь редактировать сотрудника" do
      employee = @chair.find_employee(@employee.id)
      employee = @chair.update_employee(@employee.id, "surname" => "Иванов",
                                                      "name" => "Иван",
                                                      "patronymic" => "Иванович",
                                                      "post" => "доцент",
                                                      "human_id" => 0)
      employee.full_name.should eql "Иванов Иван Иванович"
      employee.reload.employees.first.post.should eql "доцент"
    end

    it "пользователь не может занимать две должности на одной кафедре" do
      new_employee = @chair.create_employee("surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "post" => "доцент",
                                    "human_id" => @employee.id)
      new_employee.new_record?.should be true
      new_employee.errors[:base].empty?.should eql false
    end

    it "если добавляем сотрудника из существующего пользователя" do
      chair = Factory.create(:chair)
      new_employee = chair.create_employee("surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "post" => "доцент",
                                    "human_id" => @employee.id)
      new_employee.should eql @employee
      role = new_employee.employees.where(:chair_id => chair).first
      role.accepted?.should be true
      role.post.should eql "доцент"
    end

    it "если добавляем сотрудника для существующего пользователя, но не заполнили должность" do
      new_employee = @chair.create_employee("surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "human_id" => @employee.id)
      new_employee.new_record?.should be true
      new_employee.errors[:post].empty?.should be false
      @employee.employees.count.should be 1
    end
  end

end

# == Schema Information
#
# Table name: chairs
# Human name: Кафедра
#
#  id         :integer         not null, primary key
#  faculty_id :integer
#  name       :string(255)     'Название'
#  abbr       :string(255)     'Аббревиатура'
#  slug       :string(255)     'Слаг'
#  created_at :datetime
#  updated_at :datetime
#

