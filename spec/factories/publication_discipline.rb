# encoding: utf-8

Factory.define :publication_discipline,
  :default_strategy => :attributes_for do |publication_discipline|
  publication_discipline.association :publication
  publication_discipline.association :discipline, :factory => :discipline
end

