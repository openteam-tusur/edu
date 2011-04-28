# encoding: utf-8

Factory.define :plan_education,
  :default_strategy => :attributes_for,
  :class => 'Education' do |education|
  education.association :semester, :factory => :plan_semester
  education.association :study, :factory => :plan_study
end

