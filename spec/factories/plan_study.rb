# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.discipline_name {|n| "Название дисциплины #{n}" }

Factory.define :plan_study,
  :default_strategy => :attributes_for,
  :class => 'Plan::Study' do |education|
  education.association :curriculum, :factory => :plan_curriculum
  education.association :chair
  education.discipline_name { Sham.discipline_name }
end

