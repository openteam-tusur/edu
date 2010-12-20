# encoding: utf-8

Factory.define :speciality, :default_strategy => :attributes_for do |speciality|
  speciality.association :chair

  speciality.code '230102'
  speciality.name 'Автоматизированные системы обработки информации и управления'
  speciality.qualification 'инженер'
  speciality.degree 'specialist'
end

