# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.chair_name { |n| "Кафедра автоматизации обработки информации #{n}" }
Sham.chair_abbr { |n| "АОИ#{n}" }
Sham.chair_slug { |n| "aoi#{n}" }

Factory.define :chair, :default_strategy => :attributes_for do |chair|
  chair.association :faculty
  chair.name { Sham.chair_name }
  chair.abbr { Sham.chair_abbr }
  chair.slug { Sham.chair_slug }
end

