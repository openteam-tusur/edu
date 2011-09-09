# encoding: utf-8

require 'ryba'

Factory.define :human, :default_strategy => :attributes_for do |human|
  human.gender {  Ryba::Name.gender }
  human.name { |human| Ryba::Name.first_name(human.gender) }
  human.patronymic { |human| Ryba::Name.middle_name(human.gender) }
  human.surname { |human| Ryba::Name.family_name(human.gender) }
end

