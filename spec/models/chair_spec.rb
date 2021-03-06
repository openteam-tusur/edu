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
      @curriculum_1 = Factory.create(:curriculum)
      @curriculum_2 = Factory.create(:curriculum)
      @study = Factory.create(:study, :curriculum => @curriculum_1, :chair => @chair)
      @chair.provided_curriculums.all.should eql [@curriculum_1]
      @chair.provided_specialities.all.should eql [@curriculum_1.speciality]
    end

    it "должна отдавать сгруппированные по study специальности" do
      Speciality.destroy_all
      speciality_b_210041 = Factory.create(:speciality, :degree => "bachelor", :code => "210041")
      Factory.create(:study,
              :curriculum => Factory.create(:curriculum, :speciality => speciality_b_210041),
              :discipline_name => "Математика",
              :chair => @chair)
      speciality_b_210040 = Factory.create(:speciality, :degree => "bachelor", :code => "210040")
      Factory.create(:study,
              :curriculum => Factory.create(:curriculum, :speciality => speciality_b_210040),
              :discipline_name => "Математика",
              :chair => @chair)
      speciality_s_210040 = Factory.create(:speciality, :degree => "specialist", :code => "210040")
      Factory.create(:study,
              :curriculum => Factory.create(:curriculum, :speciality => speciality_s_210040),
              :discipline_name => "Математика",
              :chair => @chair)


      expected = {
        speciality_b_210041.degree => [speciality_b_210040, speciality_b_210041],
        speciality_s_210040.degree => [speciality_s_210040]
      }

      @chair.grouped_provided_specialities.should eql expected
    end

    it "должна знать учебные планы и статистику дисциплин по общеспечивающим дисциплинам по специальности" do
      speciality_s_210040 = Factory.create(:speciality, :degree => "specialist", :code => "210040")
      fulltime_curriculum =  Factory.create(:curriculum,
                                            :speciality => speciality_s_210040,
                                            :study_form => "fulltime")
      parttime_curriculum =  Factory.create(:curriculum,
                                            :speciality => speciality_s_210040,
                                            :study_form => "parttime")
      Factory.create(:education,
              :semester => fulltime_curriculum.semesters.first,
              :study => Factory.create(:study, :chair => @chair, :curriculum => fulltime_curriculum))
      Factory.create(:education,
              :semester => fulltime_curriculum.semesters.first,
              :study => Factory.create(:study, :chair => @chair, :curriculum => fulltime_curriculum))
      Factory.create(:education,
              :semester => parttime_curriculum.semesters.first,
              :study => Factory.create(:study, :chair => @chair, :curriculum => parttime_curriculum))

      expected = {
        fulltime_curriculum => 2,
        parttime_curriculum => 1
      }

      @chair.grouped_curriculums_for_speciality(speciality_s_210040).should eql expected
    end

    it "должна определяться обеспеченность educations для учебного плана рабочей программой и учебным пособием" do
      speciality = Factory.create(:speciality, :degree => "specialist", :code => "210040")
      fulltime_curriculum =  Factory.create(:curriculum,
                                            :speciality => speciality,
                                            :study_form => "fulltime")
      education_1 = Factory.create( :education,
                                    :semester => fulltime_curriculum.semesters.first,
                                    :study => Factory.create(:study, :chair => @chair, :curriculum => fulltime_curriculum))
      education_2 = Factory.create( :education,
                                    :semester => fulltime_curriculum.semesters.last,
                                    :study => Factory.create(:study, :chair => @chair,
                                              :curriculum => fulltime_curriculum, :discipline => education_1.study.discipline))

      work_program = Factory.create(:publication, :chair => @chair, :kind => "work_programm")
      work_program.publish!
      work_program.publication_disciplines.create!(:discipline => education_1.study.discipline,
          :education_ids => [education_1.id, education_2.id])

      tutorial = Factory.create(:publication, :chair => @chair, :kind => "tutorial")
      tutorial.publication_disciplines.create!(:discipline => education_1.study.discipline,
          :education_ids => [education_1.id])

      Sunspot.commit

      wp_expected = {:educations => 2, :provided => 2, :class => "provided"}
      @chair.provided_curriculum_by_work_programm(fulltime_curriculum).should eql wp_expected

      tutorial_expected = {:educations => 2, :provided => 0, :class => "unprovided"}
      @chair.provided_curriculum_by_tutorial(fulltime_curriculum).should eql tutorial_expected
    end

  end

end


# == Schema Information
#
# Table name: chairs
#
#  id         :integer         not null, primary key
#  faculty_id :integer
#  name       :string(255)
#  abbr       :string(255)
#  slug       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

