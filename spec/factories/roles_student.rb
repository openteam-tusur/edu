 # encoding: utf-8

Factory.define :roles_student,
               :class => Roles::Student,
               :default_strategy => :attributes_for do |roles_student|
  roles_student.association :human
  roles_student.group       '123-4'
  roles_student.birthday    '10.10.1990'
end

