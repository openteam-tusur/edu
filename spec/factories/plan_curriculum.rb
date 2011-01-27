# encoding: utf-8

Factory.define :plan_curriculum,
  :default_strategy => :attributes_for,
  :class => 'Plan::Curriculum' do |curriculum|
  curriculum.association :speciality
  curriculum.study 'fulltime'
  curriculum.since 2010
  curriculum.association :chair
end

