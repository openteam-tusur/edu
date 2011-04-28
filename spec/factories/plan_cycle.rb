# encoding: utf-8

Factory.define :cycle,
               :default_strategy => :attributes_for,
               :class => 'Cycle' do |cycle|
  cycle.code 'С1'
  cycle.name 'Математический и естественнонаучный цикл'
  cycle.degree 'specialist'
end

