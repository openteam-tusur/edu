# encoding: utf-8

require 'spec_helper'

describe Chair do

  describe "при работе с сотрудниками" do
    before(:each) do
      @chair = Factory.create(:chair)
      @teacher = @chair.create_teacher("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель")
    end

    it "должна уметь создавать сотрудника" do
      @teacher.new_record?.should be false
      role = @teacher.teachers.first
      role.accepted?.should be true
      role.chair.should eql @chair
    end

    it "должна быть ошибка если не указана должность" do
      teacher = @chair.create_teacher("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество")
      teacher.errors[:post].should_not be nil
    end

    it "должна знать сотрудников" do
      expired_teacher_chair = @chair.create_teacher("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель")
      expired_teacher_chair.teachers.first.expire!
      chair_2 = Factory.create(:chair)
      teacher_chair_2 = chair_2.create_teacher("surname" => "Фамилия",
                                    "name" => "Имя",
                                    "patronymic" => "Отчество",
                                    "post" => "старший преподаватель")
      @chair.teachers.should eql [@teacher]
    end

    it "должна уметь редактировать сотрудника" do
      teacher = @chair.find_teacher(@teacher.id)
      teacher = @chair.update_teacher(@teacher.id, "surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "post" => "доцент")
      teacher.full_name.should eql "Иванов Иван Иванович"
      teacher.reload.teachers.first.post.should eql  "доцент"
    end

    it "если добавляем сотрудника из существующего пользователя" do
      new_employee = @chair.create_teacher("surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "post" => "доцент",
                                    "human_id" => @teacher.id)
      new_employee.should eql @teacher
      role = new_employee.teachers.where(:chair_id => @chair).first
      role.accepted?.should be true
      role.post.should eql "доцент"
    end

    it "если добавляем сотрудника для существующего пользователя, но не заполнили должность" do
      new_employee = @chair.create_teacher("surname" => "Иванов",
                                    "name" => "Иван",
                                    "patronymic" => "Иванович",
                                    "human_id" => @teacher.id)
      new_employee.new_record?.should be true
      new_employee.errors[:post].empty?.should be false
      @teacher.teachers.count.should be 1
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

