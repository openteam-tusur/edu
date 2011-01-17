# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.discipline_name {|n| "Название дисциплины #{n}" }

Factory.define :plan_education,
  :default_strategy => :attributes_for,
  :class => 'Plan::Education' do |education|
  education.discipline_name { Sham.discipline_name }
  education.association :semester, :factory => :plan_semester
  education.association :chair
end

