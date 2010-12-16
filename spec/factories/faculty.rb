# encoding: utf-8

Sham.faculty_name {|n| "Факультет систем управления #{n}" }
Sham.faculty_abbr {|n| "ФСУ#{n}" }
Sham.faculty_slug {|n| "fsu#{n}" }

Factory.define :faculty, :default_strategy => :attributes_for do |faculty|
  faculty.name { Sham.faculty_name }
  faculty.abbr { Sham.faculty_abbr }
  faculty.slug { Sham.faculty_slug }
end

