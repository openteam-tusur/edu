# encoding: utf-8
require 'factory_girl/syntax/sham'

Sham.semester_number {|n| n }

Factory.define :speciality_semester,
  :default_strategy => :attributes_for,
  :class => 'Plan::Semester' do |semester|
  semester.association :speciality
  semester.number { Sham.semester_number }
end

