# encoding: utf-8

Factory.define :education,
  :default_strategy => :attributes_for,
  :class => 'Education' do |education|
  education.association :semester, :factory => :semester
  education.association :study, :factory => :study
end

