# encoding: utf-8

require 'factory_girl/syntax/sham'

Sham.speciality_code {|n| "21000#{n}" }
Sham.speciality_name {|n| "Специальность 21000#{n}" }

Factory.define :speciality, :default_strategy => :attributes_for do |speciality|
  speciality.code { Sham.speciality_code }
  speciality.name { Sham.speciality_name }
  speciality.qualification 'инженер'
  speciality.degree 'specialist'
end

