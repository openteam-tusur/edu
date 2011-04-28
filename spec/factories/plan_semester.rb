# encoding: utf-8
require 'factory_girl/syntax/sham'

Sham.semester_number {|n| n }

Factory.define :plan_semester,
  :default_strategy => :attributes_for,
  :class => 'Semester' do |semester|
  semester.association :curriculum, :factory => :plan_curriculum
  semester.number { Sham.semester_number }
end

