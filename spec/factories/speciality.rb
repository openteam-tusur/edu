# encoding: utf-8

Factory.define :speciality, :default_strategy => :attributes_for do |speciality|
  speciality.association :chair
  speciality.licence { Factory.build(:speciality_licence, :speciality => nil) }
  speciality.accreditation { Factory.build(:speciality_accreditation, :speciality => nil) }

  speciality.code '230102'
  speciality.name 'Автоматизированные системы обработки информации и управления'
  speciality.qualification 'инженер'
  speciality.degree 'specialist'
  speciality.semesters_count 10
end

