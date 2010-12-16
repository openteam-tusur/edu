# encoding: utf-8

Factory.define :chair, :default_strategy => :attributes_for do |chair|
  chair.association :faculty
  chair.name 'Кафедра автоматизации обработки информации'
  chair.abbr 'АОИ'
  chair.slug 'aoi'
end

