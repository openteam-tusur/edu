# encoding: utf-8

require 'spec_helper'

describe Chair do
  before(:each) do
    @chair = Factory.create(:chair, :abbr => "АОИ")
  end

  describe "при работе с сотрудниками" do
    before(:each) do
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

    it "должна создавать сотрудников" do
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
                                                      "post" => "доцент")
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

  describe "статистика обеспечиваемых дисциплин" do

    it "кафедра должна знать учебные планы и по которым она обеспечивает обучение" do
      @curriculum_1 = Factory.create(:plan_curriculum)
      @curriculum_2 = Factory.create(:plan_curriculum)
      @education_1_1 = Factory.create(:plan_education, :semester => @curriculum_1.semesters.first, :chair => @chair)
      @chair.provided_curriculums.all.should eql [@curriculum_1]
      @chair.provided_specialities.all.should eql [@curriculum_1.speciality]
    end

    it "должна отдавать сгруппированные по study и кафедре специальности" do
      Speciality.count
      speciality_b_210041 = Factory.create(:speciality, :degree => "bachelor", :chair => @chair, :code => "210041")
      Factory.create(:plan_education,
              :semester => Factory.create(:plan_curriculum, :speciality => speciality_b_210041).semesters.first,
              :chair => @chair)
      speciality_b_210040 = Factory.create(:speciality, :degree => "bachelor", :chair => @chair, :code => "210040")
      Factory.create(:plan_education,
              :semester => Factory.create(:plan_curriculum, :speciality => speciality_b_210040).semesters.first,
              :chair => @chair)
      speciality_s_210040 = Factory.create(:speciality, :degree => "specialist", :chair => @chair, :code => "210040")
      Factory.create(:plan_education,
              :semester => Factory.create(:plan_curriculum, :speciality => speciality_s_210040).semesters.first,
              :chair => @chair)

      chair_srs = Factory.create(:chair, :abbr => "СРС")
      speciality_b_110041 = Factory.create(:speciality, :degree => "bachelor", :chair => chair_srs, :code => "110041")
      Factory.create(:plan_education,
              :semester => Factory.create(:plan_curriculum, :speciality => speciality_b_110041).semesters.first,
              :chair => @chair)


      expected = {
        speciality_b_210041.degree => {
          @chair => [speciality_b_210040, speciality_b_210041],
          chair_srs => [speciality_b_110041]
        },
        speciality_s_210040.degree => {
          @chair => [speciality_s_210040]
        }
      }

      @chair.grouped_provided_specialities.should eql expected
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

