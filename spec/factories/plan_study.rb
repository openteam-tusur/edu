# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.discipline_name {|n| "Название дисциплины #{n}" }

Factory.define :study,
  :default_strategy => :attributes_for,
  :class => 'Study' do |study|
  study.association :curriculum, :factory => :curriculum
  study.association :chair
  study.discipline_name { Sham.discipline_name }
  study.cycle_id { Factory.create(:cycle).id }
end

