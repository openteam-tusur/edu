# encoding: utf-8

Factory.define :resource_discipline,
  :default_strategy => :attributes_for do |resource_discipline|
  resource_discipline.association :resource, :factory => :work_programm
  resource_discipline.association :discipline, :factory => :plan_discipline
end

