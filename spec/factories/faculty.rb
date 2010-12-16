# encoding: utf-8

Factory.define :faculty, :default_strategy => :attributes_for do |faculty|
  faculty.name 'Факультет систем управления'
  faculty.abbr 'ФСУ'
  faculty.slug 'fsu'
end

