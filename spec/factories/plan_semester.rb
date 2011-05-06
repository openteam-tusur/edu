# encoding: utf-8
require 'factory_girl/syntax/sham'

Sham.semester_number {|n| n }

Factory.define :semester,
  :default_strategy => :attributes_for,
  :class => 'Semester' do |semester|
  semester.association :curriculum, :factory => :curriculum
  semester.number { Sham.semester_number }
end

