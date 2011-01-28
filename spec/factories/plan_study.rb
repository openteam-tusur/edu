# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.discipline_name {|n| "Название дисциплины #{n}" }

Factory.define :plan_study,
  :default_strategy => :attributes_for,
  :class => 'Plan::Study' do |study|
  study.association :curriculum, :factory => :plan_curriculum
  study.association :chair
  study.discipline_name { Sham.discipline_name }
  study.cycle "special"
end

