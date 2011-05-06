# encoding: utf-8

YAML.load_file(Rails.root.join('config', 'faculties.yml')).each do |slug, attributes|
  faculty = Faculty.find_or_initialize_by_slug(slug)
  chairs = attributes.delete('chairs')
  faculty.update_attributes! attributes
  next unless chairs
  chairs.each do | slug, attributes |
    chair = faculty.chairs.find_or_initialize_by_slug slug
    chair.update_attributes! attributes
  end
end

YAML.load_file(Rails.root.join('config', 'dictionaries.yml')).each do |model, dictionary|
  klass = model.singularize.camelize.constantize
  dictionary.each do |slug, attributes|
    klass.find_or_initialize_by_slug(slug).update_attributes! attributes
  end
end

Human.destroy_all
User.destroy_all
Role.destroy_all

admin = User.create( :email => 'admin@demo.de',
                     :password => '123123',
                     :password_confirmation => '123123' )
admin.human.update_attributes( :name => 'Иван',
                               :surname => 'Иванов',
                               :patronymic => 'Иванович' )
admin.human.roles << Admin.new( :state => :accepted )


user = User.create( :email => 'user@demo.de',
                    :password => '123123',
                    :password_confirmation => '123123' )
user.human.update_attributes(:name => 'Петр',
                             :surname => 'Петров',
                             :patronymic => 'Петрович' )
user.human.roles << Student.new(:group => '422',
                                :birthday => '01.01.1970',
                                :state => :accepted)

user.human.roles << Employee.new(:chair_id => Chair.find_by_slug('asu'),
                                 :post => 'Старший преподаватель',
                                 :state => :accepted)

Speciality.destroy_all

Cycle.destroy_all

b1 = Cycle.create!(:code => 'Б1',
                   :name => 'Гуманитарный, социальный и экономический цикл',
                   :degree => 'bachelor')

b2 = Cycle.create!(:code => 'Б2',
                   :name => 'Математический и естственнонаучный цикл',
                   :degree => 'bachelor')

b3 = Cycle.create!(:code => 'Б3',
                   :name => 'Профессиональный цикл',
                   :degree => 'bachelor')

b4 = Cycle.create!(:code => 'Б4',
                   :name => 'Физическая культура',
                   :degree => 'bachelor')

b5 = Cycle.create!(:code => 'Б5',
                   :name => 'Учебная и производственная практики',
                   :degree => 'bachelor')

b6 = Cycle.create!(:code => 'Б6',
                   :name => 'Итоговая государственная аттестация',
                   :degree => 'bachelor')

ftd = Cycle.create!(:code => 'ФТД',
                   :name => 'Факультативы',
                   :degree => 'bachelor')

m1 = Cycle.create!(:code => 'М1',
                   :name => 'Общенаучный цикл',
                   :degree => 'master')

m2 = Cycle.create!(:code => 'М2',
                   :name => 'Профессиональный цикл',
                   :degree => 'master')

m3 = Cycle.create!(:code => 'М3',
                   :name => 'Практика и научно-исследовательская работы',
                   :degree => 'master')

m4 = Cycle.create!(:code => 'М4',
                   :name => 'Итоговая аттестация',
                   :degree => 'master')

s1 = Cycle.create!(:code => 'С1',
                   :name => 'Гуманитарный, социальный и экономический цикл',
                   :degree => 'specialist')

s2 = Cycle.create!(:code => 'С2',
                   :name => 'Математический и естственнонаучный цикл',
                   :degree => 'specialist')

s3 = Cycle.create!(:code => 'С3',
                   :name => 'Профессиональный цикл',
                   :degree => 'specialist')

s4 = Cycle.create!(:code => 'С4',
                   :name => 'Физическая культура',
                   :degree => 'specialist')

s5 = Cycle.create!(:code => 'С5',
                   :name => 'Учебная и производственная практики',
                   :degree => 'specialist')

s6 = Cycle.create!(:code => 'С6',
                   :name => 'Итоговая аттестация',
                   :degree => 'specialist')

svchkr = Chair.find_by_slug('svchkr')

s210401 = Speciality.create! :code           => 210401,
                             :name           => 'Физика и техника оптической связи',
                             :degree         => 'specialist',
                             :qualification  => 'инженер',
                             :licence_attributes => {
                               :number     => 'А № 282322',
                               :issued_on  => '21.05.2008'
                             },
                             :accreditation_attributes => {
                               :number     => 'АА № 001373',
                               :issued_on  => '23.06.08'
                             }

curriculum = s210401.curriculums.create! :study_form => 'fulltime',
                                         :state => 'published',
                                         :since => '2008',
                                         :semesters_count => 10,
                                         :chair => svchkr

study1 = curriculum.studies.create! :chair => Chair.find_by_slug('iya'),
                                    :discipline_name => 'Иностранный язык',
                                    :cycle_id => s1.id

study2 = curriculum.studies.create! :chair => Chair.find_by_slug('fvis'),
                                    :discipline_name => 'Физическая культура',
                                    :cycle_id => s4.id

study3 = curriculum.studies.create! :chair => Chair.find_by_slug('mguk'),
                                    :discipline_name => 'Инженерная и компьютерная графика',
                                    :cycle_id => s2.id

study4 = curriculum.studies.create! :chair => svchkr,
                                    :discipline_name => 'Химия радиоматериалов',
                                    :cycle_id => s3.id

semester1 = curriculum.semesters.find_by_number 1

semester1.educations.create! :study => study1

semester1.educations.create! :study => study2

semester1.educations.create! :study => study3

semester2 = curriculum.semesters.find_by_number 2

semester2.educations.create! :study => study2

semester2.educations.create! :study => study1

semester2.educations.create! :study => study4

