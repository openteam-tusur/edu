# encoding: utf-8
require 'factory_girl/syntax/sham'

Sham.discipline_name {|n| "Название дисциплины #{n}" }

Factory.define :plan_discipline,
  :default_strategy => :attributes_for,
  :class => 'Plan::Discipline' do |semester|
  semester.association :speciality
  semester.name { Sham.discipline_name }
end

