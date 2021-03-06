# encoding: utf-8

Factory.define :curriculum,
  :default_strategy => :attributes_for,
  :class => 'Curriculum' do |curriculum|
  curriculum.association :speciality
  curriculum.study_form 'fulltime'
  curriculum.since 2010
  curriculum.semesters_count 10
  curriculum.association :chair
end

