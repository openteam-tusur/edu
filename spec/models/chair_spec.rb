# encoding: utf-8

require 'spec_helper'

describe Chair do

  describe "при работе с сотрудниками" do
    before(:each) do
      @chair = Factory.create(:chair)
      @employee = @chair.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель")
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
                                    "post" => "старший преподаватель")
      expired_employee_chair.employees.first.expire!
      chair_2 = Factory.create(:chair)
      employee_chair_2 = chair_2.create_employee("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель")
      @chair.employees.should eql [@employee]
    end

    it "должна уметь редактировать сотрудника" do
      employee = @chair.find_employee(@employee.id)
      employee = @chair.update_employee(@employee.id, "surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "post" => "доцент")
      employee.full_name.should eql "Иванов Иван Иванович"
      employee.reload.employees.first.post.should eql  "доцент"
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

